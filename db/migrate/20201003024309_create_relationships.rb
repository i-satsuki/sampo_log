class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :follow_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
