class RemoveEventColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :event_logs, :event
  end
end
