class CreateFclExwStepsBookingInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_steps_booking_infos do |t|
    	t.references :operation, foreign_key: true
    	t.string :booking_number
    	t.string :vessel
    	t.string :voyage
    	t.date :doc_cut_off_date
    	t.time :doc_cut_off_time
    	t.date :cargo_cut_off_date
    	t.time :cargo_cut_off_time
    	t.date :sailing_date
    	t.date :arrival_date
        t.date :vgm_cut_off_date
        t.string :ramp
        t.date :ramp_cut_off_date
      t.timestamps
    end
  end
end
