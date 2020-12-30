class AddOrganisationIdToBatchInvitations < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :batch_invitations, :organisation_id, :integer
  end
end
