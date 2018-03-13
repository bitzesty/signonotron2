class MakeUsersSuspendable < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :users, :suspended_at, :datetime
  end
end
