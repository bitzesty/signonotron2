class AddLastSyncedAtToPermission < ActiveRecord::Migration[5.1][5.0]
  def up
    add_column :permissions, :last_synced_at, :datetime
    execute("update permissions set last_synced_at = updated_at")
  end
end
