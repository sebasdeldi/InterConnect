class CreatePieces < ActiveRecord::Migration[5.1]
  # A piece acts also as a container for FCL
  def change
    create_table :pieces do |t|
      #t.references :general_cargo_info, foreign_key: true
      t.references :fcl_exw_cargo_info_step, foreign_key: true
      t.string :sort
      t.float :gross_weight
      t.text :commercial_description
      t.string :cargo_hazardous
      t.string :container_size
      t.string :hazardous_class
      t.string :un_code
      t.timestamps
    end
  end
end