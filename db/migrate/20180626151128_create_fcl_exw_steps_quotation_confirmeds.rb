class CreateFclExwStepsQuotationConfirmeds < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_steps_quotation_confirmeds do |t|
      t.boolean :completed, default: false
      t.references :operation, foreign_key: true
      t.text :additional_comment
      t.float :neta
      t.float :venta
      t.json :files
      t.timestamps
    end
  end
end
