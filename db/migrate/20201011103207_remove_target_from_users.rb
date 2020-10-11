class RemoveTargetFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :target, :integer
  end
end
