class UniqueApplicationConstraint < ActiveRecord::Migration[5.1][5.0]
  def up
    add_index :oauth_applications, "name", unique: true, name: "unique_application_name"
  end

  def down
    remove_index :oauth_applications, "unique_application_name"
  end
end
