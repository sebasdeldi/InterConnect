class CreateFclExwQuotationSellingSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_quotation_selling_steps do |t|
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
