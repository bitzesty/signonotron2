require 'rails_helper'

describe UserPolicy do
  subject { described_class }

  permissions :index? do
    it "is allowed for superadmins" do
      expect(subject).to permit(build(:superadmin_user), User)
    end

    it "is allowed for admins" do
      expect(subject).to permit(build(:admin_user), User)
    end

    it "is allowed for organisation admins" do
      expect(subject).to permit(build(:organisation_admin), User)
    end

    it "is forbidden for normal users" do
      expect(subject).not_to permit(build(:user), User)
    end
  end

  [:new?, :assign_organisations?].each do |permission|
    permissions permission do
      it "is allowed for superadmins" do
        expect(subject).to permit(build(:superadmin_user), User)
      end

      it "is allowed for admins" do
        expect(subject).to permit(build(:admin_user), User)
      end

      it "is forbidden for organisation admins" do
        expect(subject).not_to permit(build(:organisation_admin), User)
      end

      it "is forbidden for normal users" do
        expect(subject).not_to permit(build(:user), User)
      end
    end
  end

  user_management_actions = %i(
    edit?
    create?
    update?
    unlock?
    suspension?
    cancel_email_change?
    resend_email_change?
    event_logs?
  )

  user_management_actions.each do |permission_name|
    permissions permission_name do
      it "is allowed for superadmins accessing any type of user" do
        superadmin = create(:superadmin_user)

        expect(subject).to permit(superadmin, build(:user))
        expect(subject).to permit(superadmin, build(:organisation_admin))
        expect(subject).to permit(superadmin, build(:admin_user))
        expect(subject).to permit(superadmin, build(:superadmin_user))
      end

      it "is allowed for admins accessing users with equal or fewer priviledges" do
        admin = create(:admin_user)

        expect(subject).not_to permit(admin, build(:superadmin_user))
        expect(subject).to permit(admin, build(:admin_user))
        expect(subject).to permit(admin, build(:organisation_admin))
        expect(subject).to permit(admin, build(:user))
      end

      it "is forbidden for normal users accessing other normal users" do
        normal_user = create(:user)
        expect(subject).not_to permit(normal_user, build(:user))
      end
    end
  end

  org_admin_disallowed_actions = %i(
    create?
    assign_organisations?
  )

  (user_management_actions - org_admin_disallowed_actions).each do |allowed_org_admin_permission|
    permissions allowed_org_admin_permission do
      it "is allowed for organisation admins accessing normal users within their organisation" do
        organisation_admin = create(:organisation_admin)

        expect(subject).not_to permit(organisation_admin, build(:superadmin_user))
        expect(subject).not_to permit(organisation_admin, build(:admin_user))
        expect(subject).not_to permit(organisation_admin, build(:organisation_admin))
        expect(subject).not_to permit(organisation_admin, build(:user_in_organisation))

        expect(subject).to permit(organisation_admin, build(:user_in_organisation, organisation: organisation_admin.organisation))
      end
    end
  end

  org_admin_disallowed_actions.each do |disallowed_org_admin_permission|
    permissions disallowed_org_admin_permission do
      it "is forbidden for organisation admins even on normal users within their organisation" do
        organisation_admin = create(:organisation_admin)

        expect(subject).not_to permit(organisation_admin, build(:superadmin_user))
        expect(subject).not_to permit(organisation_admin, build(:admin_user))
        expect(subject).not_to permit(organisation_admin, build(:organisation_admin))
        expect(subject).not_to permit(organisation_admin, build(:user_in_organisation))
        expect(subject).not_to permit(organisation_admin, build(:user_in_organisation, organisation: organisation_admin.organisation))
      end
    end
  end

  self_management_actions = [:edit_email_or_passphrase?, :update_email?, :update_passphrase?, :cancel_email_change?, :resend_email_change?]
  self_management_actions.each do |permission_name|
    permissions permission_name do
      it "is allowed for normal users accessing their own record" do
        normal_user = create(:user)
        expect(subject).to permit(normal_user, normal_user)
      end
    end
  end

  # Users shouldn't be able to do admin-only things to themselves
  (user_management_actions - self_management_actions).each do |permission_name|
    permissions permission_name do
      it "is not allowed for normal users accessing their own record" do
        normal_user = create(:user)
        expect(subject).not_to permit(normal_user, normal_user)
      end
    end
  end

  permissions :assign_role? do
    it "is allowed only for superadmins" do
      expect(subject).to permit(create(:superadmin_user), User)

      expect(subject).not_to permit(create(:admin_user), User)
      expect(subject).not_to permit(create(:organisation_admin), User)
      expect(subject).not_to permit(create(:user), User)
    end
  end

  permissions :flag_2sv? do
    it "is only allowed for superadmins" do
      expect(subject).to permit(build(:superadmin_user), User)

      expect(subject).not_to permit(create(:admin_user), User)
      expect(subject).not_to permit(create(:organisation_admin), User)
      expect(subject).not_to permit(create(:user), User)
    end
  end

  permissions :reset_2sv? do
    it "is only allowed for superadmins" do
      expect(subject).to permit(build(:superadmin_user), User)

      expect(subject).not_to permit(create(:admin_user), User)
      expect(subject).not_to permit(create(:organisation_admin), User)
      expect(subject).not_to permit(create(:user), User)
    end
  end

  describe described_class::Scope do
    let!(:superadmin_user) { create(:superadmin_user) }
    let!(:admin_user) { create(:admin_user) }
    let!(:api_user) { create(:api_user) }

    let(:org_root_one) { create(:organisation) }
    let(:org_root_two) { create(:organisation) }
    let(:org_root_one_child) { create(:organisation, parent: org_root_one) }

    let!(:normal_user_in_org) { create(:user_in_organisation, organisation: org_root_one) }
    let!(:org_admin_user_in_org) { create(:organisation_admin, organisation: org_root_one) }
    let!(:normal_user_in_child_org) { create(:user_in_organisation, organisation: org_root_one_child) }
    let!(:org_admin_user_in_child_org) { create(:organisation_admin, organisation: org_root_one_child) }
    let!(:normal_user_in_other_org) { create(:user_in_organisation, organisation: org_root_two) }
    let!(:org_admin_user_in_other_org) { create(:organisation_admin, organisation: org_root_two) }

    subject { described_class.new(user, User.all) }
    let(:resolved_scope) { subject.resolve }

    context 'for super admins' do
      let(:user) { create(:superadmin_user) }

      it 'includes all web users' do
        expect(resolved_scope).to include(superadmin_user)
        expect(resolved_scope).to include(admin_user)
        expect(resolved_scope).to include(normal_user_in_org)
        expect(resolved_scope).to include(org_admin_user_in_org)
        expect(resolved_scope).to include(normal_user_in_child_org)
        expect(resolved_scope).to include(org_admin_user_in_child_org)
        expect(resolved_scope).to include(normal_user_in_other_org)
        expect(resolved_scope).to include(org_admin_user_in_other_org)
      end

      it 'does not include api users' do
        expect(resolved_scope).not_to include(api_user)
      end
    end

    context 'for admins' do
      let(:user) { create(:admin_user) }

      it 'includes all web users of similar permissions' do
        expect(resolved_scope).to include(admin_user)
        expect(resolved_scope).to include(normal_user_in_org)
        expect(resolved_scope).to include(org_admin_user_in_org)
        expect(resolved_scope).to include(normal_user_in_child_org)
        expect(resolved_scope).to include(org_admin_user_in_child_org)
        expect(resolved_scope).to include(normal_user_in_other_org)
        expect(resolved_scope).to include(org_admin_user_in_other_org)
      end

      it 'does not include api users' do
        expect(resolved_scope).not_to include(api_user)
      end

      it 'does not include superadmins' do
        expect(resolved_scope).not_to include(superadmin_user)
      end
    end

    context 'for org admins' do
      let(:user) { create(:organisation_admin, organisation: org_root_one) }

      it 'includes only org admins and users belonging to their org' do
        expect(resolved_scope).to include(normal_user_in_org)
        expect(resolved_scope).to include(org_admin_user_in_org)
      end

      it 'does not include users belonging to organisations in their subtree' do
        expect(resolved_scope).not_to include(normal_user_in_child_org)
        expect(resolved_scope).not_to include(org_admin_user_in_child_org)
      end

      it 'does not include users belonging to other orgs' do
        expect(resolved_scope).not_to include(normal_user_in_other_org)
        expect(resolved_scope).not_to include(org_admin_user_in_other_org)
      end

      it 'does not include api users' do
        expect(resolved_scope).not_to include(api_user)
      end

      it 'does not include superadmins (even if they are in the same org)' do
        superadmin_in_same_org = create(:superadmin_user, organisation: user.organisation)
        expect(resolved_scope).not_to include(superadmin_user)
        expect(resolved_scope).not_to include(superadmin_in_same_org)
      end

      it 'does not include admins (even if they are in the same org)' do
        admin_in_same_org = create(:admin_user, organisation: user.organisation)
        expect(resolved_scope).not_to include(admin_user)
        expect(resolved_scope).not_to include(admin_in_same_org)
      end
    end

    context 'for normal users' do
      let(:user) { create(:user) }

      it 'is empty' do
        expect(resolved_scope).to be_empty
      end
    end
  end
end
