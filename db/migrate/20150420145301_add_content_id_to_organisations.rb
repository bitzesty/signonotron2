class AddContentIdToOrganisations < ActiveRecord::Migration[5.1][5.0]
  def change
    # This can be made not-nullable once populated
    add_column :organisations, :content_id, :string
    add_index :organisations, :content_id, unique: true
  end
end
