class AddInvitationCreatedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :invitation_created_at, :datetime
  end
end
