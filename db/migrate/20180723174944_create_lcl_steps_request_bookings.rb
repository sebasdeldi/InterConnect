class CreateLclStepsRequestBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :lcl_steps_request_bookings do |t|
      t.boolean :completed, default: false
      t.references :operation, foreign_key: true
      t.string :additional_message
      t.integer :carrier_id
      t.timestamps
    end
  end
end
