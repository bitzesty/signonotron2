require 'sso_push_client'

class PermissionUpdater < PushUserUpdatesJob
  def perform(uid, application_id)
    Rails.logger.info ""
    Rails.logger.info "-" * 100
    Rails.logger.info ""
    Rails.logger.info "PermissionUpdater: runned (uid: #{uid}, application_id: #{application_id})"
    Rails.logger.info ""
    Rails.logger.info "-" * 100
    Rails.logger.info ""

    user = User.find_by_uid(uid)
    application = ::Doorkeeper::Application.find_by_id(application_id)
    # It's possible they've been deleted between when the job was scheduled and run.
    return if user.nil? || application.nil?

    api = SSOPushClient.new(application)
    presenter = UserOAuthPresenter.new(user, application)
    api.update_user(user.uid, presenter.as_hash)

    user.permissions_synced!(application)
  end
end
