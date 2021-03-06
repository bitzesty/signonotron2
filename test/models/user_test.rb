require "test_helper"
require "bcrypt"

class UserTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def setup
    Rails.application.config.stubs(instance_name: nil)

    @user = create(:user)
  end

  context "#require_2sv" do
    should "default to false for normal users" do
      assert_not create(:user).require_2sv?
    end

    should "default to true for admins and superadmins in production" do
      assert create(:admin_user).require_2sv?
      assert create(:superadmin_user).require_2sv?
    end

    should "default to false for admins and superadmins in non-production" do
      Rails.application.config.stubs(instance_name: "foobar")

      assert_not create(:admin_user).require_2sv?
      assert_not create(:superadmin_user).require_2sv?
    end

    should "default to true when a user is promoted to admin" do
      user = create(:user)
      user.update!(role: "admin")
      assert user.require_2sv?
    end

    should "default to true when a user is promoted to superadmin" do
      user = create(:user)
      user.update!(role: "superadmin")
      assert user.require_2sv?
    end

    should "default to true when an admin is promoted to superadmin" do
      user = create(:admin_user)
      user.update!(role: "superadmin")
      assert user.require_2sv?
    end

    should "remain true when an admin is demoted" do
      user = create(:admin_user)
      user.update!(role: "normal")
      assert user.require_2sv?
    end

    should "not change if other changes are made to an admin" do
      user = create(:admin_user)
      user.update!(require_2sv: false)
      user.update!(name: "Foo Bar")
      assert_not user.require_2sv?
    end
  end

  context "#send_two_step_flag_notification?" do
    context "when not flagged" do
      should "return false" do
        assert_not @user.send_two_step_flag_notification?
      end

      context "when flagging" do
        should "maintain after persisting" do
          @user.update!(require_2sv: true)

          assert @user.send_two_step_flag_notification?
        end
      end

      context "when promoting a user" do
        should "be true" do
          @user.update!(role: "admin")

          assert @user.send_two_step_flag_notification?
        end
      end
    end

    context "when already flagged" do
      should "return false" do
        @user.toggle(:require_2sv)

        assert_not @user.reload.send_two_step_flag_notification?
      end
    end
  end

  context "#reset_2sv!" do
    setup do
      @super_admin   = create(:superadmin_user)
      @two_step_user = create(:two_step_enabled_user)
      @two_step_user.reset_2sv!(@super_admin)
    end

    should "persist the required attributes" do
      @two_step_user.reload

      assert_not @two_step_user.has_2sv?
      assert @two_step_user.prompt_for_2sv?
    end

    should "record the event" do
      assert_equal 1,
                   EventLog.where(
                     event_id: EventLog::TWO_STEP_RESET.id,
                     uid: @two_step_user.uid,
                     initiator: @super_admin,
                   ).count
    end
  end

  context "#prompt_for_2sv?" do
    context "when the user has already enrolled" do
      should "always be false" do
        assert_not build(:two_step_flagged_user, otp_secret_key: "welp").prompt_for_2sv?
      end
    end
  end

  test "email change tokens should expire" do
    @user = create(:user_with_pending_email_change, confirmation_sent_at: 15.days.ago)
    @user.confirm
    assert_equal "needs to be confirmed within 14 days, please request a new one", @user.errors[:email][0]
  end

  # Scopes

  test "web_users includes non api users" do
    assert_includes User.web_users, @user
  end

  test "web_users excludes api users" do
    assert_not_includes User.web_users, create(:api_user)
  end

  test "fetches web users who signed_in X days ago" do
    create(:user, current_sign_in_at: 8.days.ago)
    signed_in_2_days_ago = create(:user, current_sign_in_at: 2.days.ago)
    create(:api_user, current_sign_in_at: 2.days.ago)

    assert_equal [signed_in_2_days_ago], User.last_signed_in_on(2.days.ago)
  end

  test "fetches web users who signed_in before X days ago" do
    create(:user, current_sign_in_at: 6.days.ago)
    signed_in_7_days_ago = create(:user, current_sign_in_at: 7.days.ago)
    signed_in_8_days_ago = create(:user, current_sign_in_at: 8.days.ago)
    create(:api_user, current_sign_in_at: 8.days.ago)

    assert_equal [signed_in_7_days_ago, signed_in_8_days_ago].sort, User.last_signed_in_before(6.days.ago).sort
  end

  test "fetches web users who signed_in after X days ago" do
    signed_in_0_days_ago = create(:user, current_sign_in_at: 0.days.ago)
    signed_in_1_day_ago  = create(:user, current_sign_in_at: 1.day.ago)
    create(:user, current_sign_in_at: 2.days.ago)

    assert_equal [signed_in_0_days_ago, signed_in_1_day_ago].sort, User.last_signed_in_after(1.day.ago).sort
  end

  context ".with_role" do
    setup do
      @admin = create(:admin_user)
      @normal = create(:user)
    end

    should "return users with specified role" do
      assert_includes User.with_role(:admin), @admin
    end

    should "not return users with a role other than the specified role" do
      assert_not_includes User.with_role(:admin), @normal
    end
  end

  context ".with_permission" do
    should "only return users with the specified permission" do
      joe = create(:user)
      amy = create(:user)
      app = create(:application, with_supported_permissions: %w[manage])
      signin_perm = app.signin_permission # created in a callback in the Application model
      manage_perm = app.supported_permissions.find_by(name: "manage")
      create(:user_application_permission, user: joe, application: app, supported_permission: signin_perm)
      create(:user_application_permission, user: amy, application: app, supported_permission: signin_perm)
      create(:user_application_permission, user: amy, application: app, supported_permission: manage_perm)

      assert_equal User.with_permission(signin_perm.id), [joe, amy]
      assert_equal User.with_permission(manage_perm.id), [amy]
    end
  end

  context ".not_recently_unsuspended" do
    should "return users who have never been unsuspended" do
      assert_includes User.not_recently_unsuspended, @user
    end

    should "not return users who have been unsuspended less than 7 days ago" do
      user2 = create(:suspended_user)
      Timecop.travel(6.days.ago) { user2.unsuspend }

      assert_not_includes User.not_recently_unsuspended, user2
    end

    should "return users who have been unsuspended more than 7 days ago" do
      user2 = create(:suspended_user)
      Timecop.travel(8.days.ago) { user2.unsuspend }

      assert_includes User.not_recently_unsuspended, user2
    end
  end

  context ".with_2sv_enabled" do
    should "return users with 2SV enabled" do
      enabled_user = create(:two_step_enabled_user)
      enabled_users = User.with_2sv_enabled(true)
      assert_equal 1, enabled_users.count
      assert_equal enabled_user, enabled_users.first

      disabled_users = User.with_2sv_enabled("false")
      assert_equal 1, disabled_users.count
      assert_equal @user, disabled_users.first
    end
  end

  context "email validation" do
    should "require an email" do
      user = build(:user, email: nil)

      assert_not user.valid?
      assert_equal ["can't be blank"], user.errors[:email]
    end

    should "accept valid emails" do
      user = build(:user)
      [
        "foo@example.com",
        "foo_bar@example.COM",
        "foo@example-domain.com",
        "user-foo+bar@really.long.domain.co.uk",
      ].each do |email|
        user.email = email

        assert user.valid?, "Expected user to be valid with email: '#{email}'"
      end
    end

    should "reject emails with invalid domain parts" do
      user = build(:user)
      [
        "foo@example.com,",
        "foo@example_domain.com",
        "foo@no-dot-domain",
      ].each do |email|
        user.email = email

        assert_not user.valid?, "Expected user to be invalid with email: '#{email}'"
        assert_equal ["is invalid"], user.errors[:email]
      end
    end

    should "convert unicode apostrophe in email to ascii equivalent" do
      user = build(:user, email: "mario’s.castle@wii.com") # unicode apostrophe character

      assert user.valid?
      assert_equal "mario's.castle@wii.com", user.email
    end

    should "emails can't contain non-ASCII characters" do
      user = build(:user, email: "mariõs.castle@wii.com") # unicode tilde character

      assert_not user.valid?
      assert_equal ["can't contain non-ASCII characters"], user.errors[:email]
    end
  end

  # Password Validation

  test "it requires a password to be at least 10 characters long" do
    u = build(:user, password: "dNG.c0w5!")
    assert_not u.valid?
    assert_not_empty u.errors[:password]
  end

  test "it allows very long passwords with spaces" do
    u = build(:user, password: ("4 l0nG sT!,ng " * 10)[0..127])
    u.valid?
    assert u.valid?
    assert_empty u.errors[:password]
  end

  test "it discourages weak passwords which reuse parts of the email" do
    u = build(:user, email: "sleuth@gmail.com", password: "sherlock holmes baker street")
    assert u.valid?

    u = build(:user, email: "sherlock.holmes@bakerstreet.com", password: "sherlock holmes baker street")
    assert_not u.valid?
    assert_not_empty u.errors[:password]
  end

  test "unlocking an account should randomise the password" do
    original_password = "sherlock holmes baker street"
    u = build(:user, email: "sleuth@gmail.com", password: original_password)

    u.suspend "suspended for shenanigans"
    u.unsuspend

    assert_not u.valid_password?(original_password)
  end

  test "it requires a reason for suspension to suspend a user" do
    u = create(:user)
    u.suspended_at = 1.minute.ago
    assert_not u.valid?
    assert_not_empty u.errors[:reason_for_suspension]
  end

  test "organisation admin must belong to an organisation" do
    user = build(:user, role: "organisation_admin", organisation_id: nil)

    assert_not user.valid?
    assert_equal "can't be 'None' for Organisation Admin", user.errors[:organisation_id].first
  end

  test "super organisation admin must belong to an organisation" do
    user = build(:user, role: "super_organisation_admin", organisation_id: nil)

    assert_not user.valid?
    assert_equal "can't be 'None' for Super Organisation Admin", user.errors[:organisation_id].first
  end

  test "it doesn't migrate password unless correct one given" do
    password = ("4 l0nG sT!,ng " * 10)[0..127]
    old_encrypted_password = ::BCrypt::Password.create(password.to_s, cost: 10).to_s

    u = create(:user)
    u.update_column :encrypted_password, old_encrypted_password
    u.reload

    assert_not u.valid_password?("something else")
    u.reload

    assert_equal old_encrypted_password, u.encrypted_password, "Changed password"
  end

  test "can grant permissions to users and return the created permission" do
    app = create(:application, name: "my_app", with_supported_permissions: ["Create publications", "Delete publications"])
    user = create(:user)

    permission = user.grant_application_permission(app, "Create publications")

    assert_equal permission, user.application_permissions.first
    assert_user_has_permissions ["Create publications"], app, user
  end

  test "granting an already granted permission doesn't cause duplicates" do
    app = create(:application, name: "my_app")
    user = create(:user)

    user.grant_application_permission(app, "signin")
    user.grant_application_permission(app, "signin")

    assert_user_has_permissions %w[signin], app, user
  end

  test "returns multiple permissions in name order" do
    app = create(:application, name: "my_app", with_supported_permissions: %w[edit])
    user = create(:user)

    user.grant_application_permission(app, "signin")
    user.grant_application_permission(app, "edit")

    assert_user_has_permissions %w[edit signin], app, user
  end

  test "inviting a user sets confirmed_at" do
    if (user = User.find_by(email: "j@1.com"))
      user.delete
    end
    user = User.invite!(name: "John Smith", email: "j@1.com")
    assert_not_nil user
    assert user.persisted?
    assert_not_nil user.confirmed_at
  end

  test "performs validations before inviting" do
    user = User.invite!(name: nil, email: "j@1.com")

    assert_not_empty user.errors
    assert_not user.persisted?
  end

  test "doesn't allow previously used password" do
    password = @user.password

    @user.password = "some v3ry s3cure password"
    @user.password_confirmation = "some v3ry s3cure password"
    @user.save!

    @user.password = password
    @user.password_confirmation = password

    assert_not @user.valid?
  end

  test "doesn't allow user to change to same password" do
    password = @user.password

    @user = User.find(@user.id)

    @user.password = password
    @user.password_confirmation = password
    assert_not @user.valid?
  end

  context "User status" do
    setup do
      @locked = create(:user)
      @locked.lock_access!
      @suspended = create(:user)
      @suspended.suspend("because grumble")
      @invited = User.invite!(name: "Oberyn Martell", email: "redviper@dorne.com")
    end

    context "filtering" do
      should "be able to filter by all statuses" do
        User::USER_STATUSES.each do |status|
          assert_not_empty User.with_status(status)
        end
      end

      should "filter suspended" do
        assert_equal [@suspended], User.with_status(User::USER_STATUS_SUSPENDED).all
      end

      should "filter invited" do
        assert_equal [@invited], User.with_status(User::USER_STATUS_INVITED).all
      end

      should "filter locked" do
        assert_equal [@locked], User.with_status(User::USER_STATUS_LOCKED).all
      end

      should "filter active" do
        assert_equal [@user], User.with_status(User::USER_STATUS_ACTIVE).all
      end
    end

    context "detecting" do
      should "detect suspended" do
        assert_equal "suspended", @suspended.status
      end

      should "detect invited" do
        assert_equal "invited", @invited.status
      end

      should "detect locked" do
        assert_equal "locked", @locked.status
      end

      should "detect active" do
        assert_equal "active", @user.status
      end
    end
  end

  context "API user status" do
    setup do
      @api_user = create(:api_user)
    end

    should "return suspended" do
      @api_user.suspend("because grumble")
      assert_equal "suspended", @api_user.status
    end

    should "return locked" do
      @api_user.lock_access!
      assert_equal "locked", @api_user.status
    end

    should "return active" do
      assert_equal "active", @api_user.status
    end

    should "not return invited" do
      api_user = User.invite!(name: "Oberyn Martell", email: "redviper@dorne.com")
      api_user.update_column :api_user, true

      assert_not_equal "invited", api_user.reload.status
    end
  end

  context "authorised applications" do
    setup do
      @user = create(:user)
      @app = create(:application)

      # authenticate access
      ::Doorkeeper::AccessToken.create!(resource_owner_id: @user.id, application_id: @app.id, token: "1234")
    end

    should "include applications the user is authorised for" do
      assert_includes @user.authorised_applications, @app
    end

    should "not include applications the user is not authorised for" do
      unused_app = create(:application)
      assert_not_includes @user.authorised_applications, unused_app
    end
  end

  context ".send_reset_password_instructions" do
    context "for a suspended user" do
      should "return the user" do
        user = create(:suspended_user)
        assert_equal user, User.send_reset_password_instructions(email: user.email)
      end

      should "notify them that reset password is disallowed and not send reset instructions" do
        user = create(:suspended_user)

        assert_enqueued_jobs 1 do
          User.send_reset_password_instructions(email: user.email)
        end
      end
    end
  end

  def assert_user_has_permissions(expected_permissions, application, user)
    permissions = user.permissions_for(application)
    assert_equal expected_permissions, permissions
  end
end
