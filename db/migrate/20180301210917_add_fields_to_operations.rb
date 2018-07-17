class AddFieldsToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :modality, :string
    add_column :operations, :status, :string
    add_column :operations, :steps_number, :float
    add_column :operations, :current_step, :float
    add_column :operations, :fcl_exw_info_requested, :boolean, default: false
    add_column :operations, :fcl_exw_info_confirmed, :boolean, default: false
    add_column :operations, :fcl_exw_quotation_confirmed, :boolean, default: false
    add_column :operations, :status_message, :string, default: " "
    add_column :operations, :reference, :string
  end
end
