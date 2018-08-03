class CreateFclExwCargoInfoSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_cargo_info_steps do |t|
      t.references :operation, foreign_key: true
      t.string :pol
      t.string :pod
      t.string :loading_address
      t.date :loading_date
      t.time :loading_time
      t.string :schedule_b_number
      t.string :pickup_reference
      t.integer :pieces_number
      t.timestamps
    end
  end
end
