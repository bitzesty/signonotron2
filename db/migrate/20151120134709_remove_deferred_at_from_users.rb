class RemoveDeferredAtFromUsers < ActiveRecord::Migration[5.1][5.0]
  def change
    remove_column :users, :deferred_2sv_at
  end
end
