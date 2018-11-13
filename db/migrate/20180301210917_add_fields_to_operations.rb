class AddFieldsToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :modality, :string
    add_column :operations, :status, :string
    add_column :operations, :steps_number, :float
    add_column :operations, :current_step, :float
    add_column :operations, :pieces_number, :float
    add_column :operations, :fcl_exw_info_requested, :boolean, default: false
    add_column :operations, :fcl_exw_info_confirmed, :boolean, default: false
    add_column :operations, :fcl_exw_quotation_confirmed, :boolean, default: false
    add_column :operations, :status_message, :string, default: " "
    add_column :operations, :reference, :string
    add_column :operations, :po_number, :string
    add_column :operations, :shipper_reference, :string
    add_column :operations, :consignee_reference, :string
    add_column :operations, :agent_reference, :string
    add_column :operations, :secure_id, :integer
    add_column :operations, :difficulty, :string
    add_column :operations, :pol, :string
    add_column :operations, :pod, :string
    add_column :operations, :origin_address, :string
    add_column :operations, :origin_zip_code, :string
    add_column :operations, :origin_city, :string
    add_column :operations, :origin_state, :string
    add_column :operations, :origin_country, :string

    add_column :operations, :destination, :string
  end
end
