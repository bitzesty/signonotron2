class AddUniqueIndexToSupportedPermissions < ActiveRecord::Migration[5.1][5.0]
  def change
    add_index :supported_permissions, [:application_id, :name], unique: true
  end
end
