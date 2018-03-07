class BulkGrantPermissionSetJob
  include Sidekiq::Worker

  def perform(id, options = {})
    BulkGrantPermissionSet.find(id).perform(options)
  end
end
