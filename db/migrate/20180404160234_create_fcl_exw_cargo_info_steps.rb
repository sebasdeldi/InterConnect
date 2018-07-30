class CreateFclExwCargoInfoSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_cargo_info_steps do |t|
      t.references :operation, foreign_key: true
      t.string :pol
      t.string :pod
      t.string :loading_address
      t.string :container_size
      t.date :loading_date
      t.time :loading_time
      t.float :gross_weight
      t.text :commercial_description
      t.string :cargo_hazardous
      t.string :hazardous_document
      t.string :schedule_b_number
      t.string :ein
      t.string :pickup_reference
      t.timestamps
    end
  end
end
