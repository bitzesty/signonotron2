class SigninPermissionsMustBeLowercase < ActiveRecord::Migration[5.1]
  def up
    SupportedPermission.where(name: 'Signin')
                       .update_all(name: 'signin')
  end
end
