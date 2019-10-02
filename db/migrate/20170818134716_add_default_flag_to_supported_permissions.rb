class AddDefaultFlagToSupportedPermissions < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :supported_permissions, :default, :boolean, default: false, null: false
  end
end
