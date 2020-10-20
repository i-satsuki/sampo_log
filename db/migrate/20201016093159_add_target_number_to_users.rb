class AddTargetNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :target_number, :integer
  end
end
