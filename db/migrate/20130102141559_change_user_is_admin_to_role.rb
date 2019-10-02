class ChangeUserIsAdminToRole < ActiveRecord::Migration[5.1][5.0]
  class User < ActiveRecord::Base; end

  def up
    add_column :users, :role, :string, default: "normal"
    User.where(is_admin: true).update_all("role = 'admin'")
    User.where(is_admin: false).update_all("role = 'normal'")
    remove_column :users, :is_admin
  end
end
