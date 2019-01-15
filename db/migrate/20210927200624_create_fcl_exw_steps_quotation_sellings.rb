class CreateFclExwStepsQuotationSellings < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_steps_quotation_sellings do |t|
      t.boolean :completed, default: false
      t.references :operation, foreign_key: true
      t.json :files
      t.float :profit
      t.float :documentation
      t.float :ff
      t.float :vgm
      t.float :inland
      t.float :others
      t.text :explanation
    end
  end
end
