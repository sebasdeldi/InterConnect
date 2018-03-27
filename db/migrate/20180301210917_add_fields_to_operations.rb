class AddFieldsToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :modality, :string
    add_column :operations, :status, :string
  end
end
