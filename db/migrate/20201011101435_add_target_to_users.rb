class AddTargetToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :target, :integer
  end
end
