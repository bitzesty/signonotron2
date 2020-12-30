class AddInitiatorIdToEventLogs < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :event_logs, :initiator_id, :integer
  end
end
