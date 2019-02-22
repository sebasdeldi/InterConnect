class CreateLclStepsCargoInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :lcl_steps_cargo_infos do |t|
    	t.references :operation, foreign_key: true
    	t.string :contact_email
    	t.string :contact_number
    	t.string :pickup_address
    	t.date :pickup_date
    	t.time :dock_hours
    	t.string :pickup_reference
    	t.integer :pieces_number
    	t.boolean :bonded
    	t.boolean :self_propelled
    	t.json :files
      t.timestamps
    end
  end
end
