class AddDefaultToEventLogsEvent < ActiveRecord::Migration[5.1]
  def up
    change_column_default :event_logs, :event, ""
  end
end
