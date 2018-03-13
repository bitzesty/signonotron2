class DropPermissionsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :permissions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
