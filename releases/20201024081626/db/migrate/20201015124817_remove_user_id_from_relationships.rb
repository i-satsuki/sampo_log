class RemoveUserIdFromRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :user_id, :integer
  end
end
