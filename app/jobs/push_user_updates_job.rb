class PushUserUpdatesJob
  include Sidekiq::Worker

  def perform
    raise NotImplementedError, "PushUserUpdatesJob must be subclassed"
  end

  class << self
    def perform_on(user)
      Rails.logger.info ""
      Rails.logger.info "-" * 100
      Rails.logger.info ""
      Rails.logger.info "#{self.class.name}: perform_on runned"
      Rails.logger.info ""
      Rails.logger.info "-" * 100
      Rails.logger.info ""

      user.applications_used
          .select(&:supports_push_updates?)
          .each do |application|

        self.perform_async(user.uid, application.id)
      end
    end
  end
end
