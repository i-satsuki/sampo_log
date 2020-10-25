class RemovePostIdFromRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :post_id, :integer
  end
end
