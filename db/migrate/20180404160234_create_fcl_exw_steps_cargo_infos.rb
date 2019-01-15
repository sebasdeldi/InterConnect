class CreateFclExwStepsCargoInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_steps_cargo_infos do |t|
      t.references :operation, foreign_key: true
      t.string :contact_email
      t.string :contact_number
      t.string :loading_address
      t.date :loading_date
      t.time :loading_time
      t.string :pickup_reference
      t.integer :pieces_number
      t.boolean :bonded
      t.boolean :self_propelled
      t.json :files
      t.timestamps
    end
  end
end
