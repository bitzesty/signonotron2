class AddApiUserToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :api_user, :boolean, default: false, null: false
  end
end
