class AddFieldsToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :type, :string
  end
end
