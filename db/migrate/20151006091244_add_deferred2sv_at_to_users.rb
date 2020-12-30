class AddDeferred2svAtToUsers < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :users, :deferred_2sv_at, :datetime, null: true
  end
end
