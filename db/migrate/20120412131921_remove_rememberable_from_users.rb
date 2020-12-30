class RemoveRememberableFromUsers < ActiveRecord::Migration[5.1][5.0]
  def change
    remove_column :users, :remember_created_at
  end
end
