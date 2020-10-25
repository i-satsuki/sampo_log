class RemoveStatusFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :status, :integer
  end
end
