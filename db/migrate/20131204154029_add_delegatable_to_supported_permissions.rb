class AddDelegatableToSupportedPermissions < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :supported_permissions, :delegatable, :boolean, default: false
  end
end
