class CreateOperationsByUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :operations_by_users do |t|
      t.references :agent
      t.references :shipper
      t.references :representative
      t.references :consignee

      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
