class FixUserUpdatePermission < ActiveRecord::Migration[5.1]
  def up
    SupportedPermission.where(name: 'user_update_permission')
                       .update_all(grantable_from_ui: false)
  end
end
