class AddPasswordChangedAtToUsers < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :users, :password_changed_at, :datetime
    User.update_all "password_changed_at = GREATEST('2013-03-06 20:00:00', confirmed_at)"
  end
end
