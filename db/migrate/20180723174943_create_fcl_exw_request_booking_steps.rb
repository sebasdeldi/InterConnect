class CreateFclExwRequestBookingSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_request_booking_steps do |t|
      t.boolean :completed, default: false
      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
