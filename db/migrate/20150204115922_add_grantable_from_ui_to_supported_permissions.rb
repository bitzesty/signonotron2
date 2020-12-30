class AddGrantableFromUiToSupportedPermissions < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :supported_permissions, :grantable_from_ui, :boolean, null: false, default: true
  end
end
