class AddFieldsToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :modality, :string
    add_column :operations, :status, :string
    add_column :operations, :fcl_exw_info_requested, :boolean, default: false
    add_column :operations, :fcl_exw_info_confirmed, :boolean, default: false

  end
end
