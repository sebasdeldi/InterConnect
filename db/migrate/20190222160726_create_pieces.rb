class CreatePieces < ActiveRecord::Migration[5.1]
  # A piece acts also as a container for FCL
  def change
    create_table :pieces do |t|
      t.references :fcl_exw_steps_cargo_info, foreign_key: true
      t.references :lcl_steps_cargo_info, foreign_key: true
      t.string :sort
      t.float :gross_weight
      t.float :height
      t.float :width
      t.float :length
      t.text :commercial_description
      t.string :cargo_hazardous
      t.string :container_size
      t.string :hazardous_class
      t.string :un_code
      t.string :container_number
      t.string :seal_number
      t.float :tare_weight

      t.timestamps
    end
  end
end