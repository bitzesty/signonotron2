class CleanupOldTable < ActiveRecord::Migration[5.1][5.0]
  def up
    # drop_table "_event_logs_old"
  end

  def down
    # This migration cannot be reversed
  end
end
