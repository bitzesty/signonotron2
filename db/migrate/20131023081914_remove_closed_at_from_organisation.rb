class RemoveClosedAtFromOrganisation < ActiveRecord::Migration[5.1]
  def up
    remove_column :organisations, :closed_at
  end

  def down
    add_column :organisations, :closed_at, :datetime
  end
end
