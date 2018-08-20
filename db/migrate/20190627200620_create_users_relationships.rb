class CreateUsersRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :users_relationships do |t|
      t.integer :user_id
      t.integer :related_id

      t.timestamps
    end
  end
end
