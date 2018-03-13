class CleanupLhmTables < ActiveRecord::Migration[5.1]
  def up
    if ActiveRecord::Base.connection.adapter_name == 'MySQL'
      Lhm.cleanup(:run)
    else
      # Postgresql doesn't support Lhm
    end
  end

  def down
    # This migration cannot be reversed
  end
end
