class BulkGrantPermissionSet < ActiveRecord::Base
  belongs_to :user
  has_many :bulk_grant_permission_set_application_permissions, inverse_of: :bulk_grant_permission_set
  has_many :supported_permissions, through: :bulk_grant_permission_set_application_permissions

  validates :user, presence: true
  validates :outcome, inclusion: { in: %w(success fail), allow_nil: true }
  validate :must_have_at_least_one_supported_permission

  def enqueue
    BulkGrantPermissionSetJob.perform_later(self.id)
  end

  def perform(_options = {})
    User.find_each do |user|
      supported_permissions.each do |permission|
        user.application_permissions.where(supported_permission_id: permission.id).first_or_create!
      end
    end
    self.outcome = "success"
    self.save!
  rescue StandardError
    self.update_column(:outcome, "fail")
    raise
  end

private

  def must_have_at_least_one_supported_permission
    errors.add(:supported_permissions, 'must add at least one permission to grant to all users') if bulk_grant_permission_set_application_permissions.size.zero?
  end
end
