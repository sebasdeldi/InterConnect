class CreateFclExwBookingInfoSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_booking_info_steps do |t|
    	t.references :operation, foreign_key: true
    	t.string :booking_number
    	t.string :vessel
    	t.string :voyage
    	t.date :doc_cut_off_date
    	t.time :doc_cut_off_time
    	t.date :cargo_cut_off_date
    	t.time :cargo_cut_off_time
    	t.date :sailing_date
    	t.time :sailing_time
    	t.date :arrival_date
    	t.time :arrival_time
        t.boolean :ramp
        t.date :ramp_cut_off_date
      t.timestamps
    end
  end
end
