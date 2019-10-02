class AddUnsuspendedAtToUser < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :users, :unsuspended_at, :datetime
  end
end
