class CleanupOldTable < ActiveRecord::Migration[5.1]
  def up
    sql = <<-eos
      SELECT EXISTS(
        SELECT * from information_schema.tables where table_name='_event_logs_old'
      )
    eos

    if ActiveRecord::Base.connection.execute(sql.strip).first["exists"] == "t"
      drop_table "_event_logs_old"
    end
  end

  def down
    # This migration cannot be reversed
  end
end
