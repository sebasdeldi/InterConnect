class CreateGeneralCargoInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :general_cargo_infos do |t|
      t.references :operation, foreign_key: true
      t.integer :pieces_number
      t.string :invoice
      t.string :packing_list
      t.string :tax_id
      t.string :pv_address
      t.timestamps
    end
  end
end
