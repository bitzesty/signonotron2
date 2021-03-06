class UniquePermissionConstraint < ActiveRecord::Migration[5.1][5.0]
  def up
    add_index :permissions, %i[application_id user_id], unique: true, name: "unique_permission_constraint"
  end

  def down
    remove_index :permissions, "unique_permission_constraint"
  end
end
