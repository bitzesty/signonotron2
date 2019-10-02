class AddRetiredToApplications < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :oauth_applications, :retired, :boolean, default: false
  end
end
