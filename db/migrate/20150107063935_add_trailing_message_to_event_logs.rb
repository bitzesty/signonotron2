class AddTrailingMessageToEventLogs < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :event_logs, :trailing_message, :string
  end
end
