class AddPasswordSaltToUsers < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :users, :password_salt, :string
    change_column :users, :encrypted_password, :string, limit: 255
  end
end
