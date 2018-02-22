class CreateOperationsByUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :operations_by_users do |t|
      t.references :user, foreign_key: true
      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
