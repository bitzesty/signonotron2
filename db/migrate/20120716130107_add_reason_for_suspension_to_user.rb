class AddReasonForSuspensionToUser < ActiveRecord::Migration[5.1][5.0]
  def change
    add_column :users, :reason_for_suspension, :string
  end
end
