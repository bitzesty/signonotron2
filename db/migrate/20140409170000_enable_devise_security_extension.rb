class EnableDeviseSecurityExtension < ActiveRecord::Migration[5.1][5.0]
  def self.up
    create_table :old_passwords do |t|
      t.string   :encrypted_password, null: false
      t.string   :password_salt
      t.integer  :password_archivable_id, null: false
      t.string   :password_archivable_type, null: false
      t.datetime :created_at
    end

    add_index :old_passwords,
              %i[password_archivable_type password_archivable_id],
              name: :index_password_archivable
  end

  def self.down
    drop_table :old_passwords
  end
end
