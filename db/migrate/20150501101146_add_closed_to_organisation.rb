class AddClosedToOrganisation < ActiveRecord::Migration[5.1]
  def change
    add_column :organisations, :closed, :boolean, default: false
  end
end
