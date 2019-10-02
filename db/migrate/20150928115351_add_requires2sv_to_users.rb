class AddRequires2svToUsers < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :users, :requires_2sv, :boolean, null: false, default: false
  end
end
