class AddSupportsPushUpdatesToApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :oauth_applications, :supports_push_updates, :boolean, default: true
  end
end
