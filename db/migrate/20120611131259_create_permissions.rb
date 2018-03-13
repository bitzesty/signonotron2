class CreatePermissions < ActiveRecord::Migration[5.1][5.0]
  def change
    create_table :permissions do |t|
      t.references :user
      t.references :application
      t.text :permissions

      t.timestamps
    end
  end
end
