class EnsureUserNameIsNotNullable < ActiveRecord::Migration[5.1][5.0]
  def up
    change_column_null(:users, :name, false)
  end
end
