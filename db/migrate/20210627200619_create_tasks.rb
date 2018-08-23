class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :note
      t.string :status, default: '0'
      t.date :due_date
      t.references :fcl_exw_info_requested_steps, foreign_key: true
      t.references :fcl_exw_info_confirmed_steps, foreign_key: true
      t.references :fcl_exw_quotation_confirmed_steps, foreign_key: true
      t.references :fcl_exw_cargo_info_steps, foreign_key: true
      t.references :fcl_exw_request_booking_steps, foreign_key: true
      t.references :fcl_exw_booking_info_steps, foreign_key: true
      t.references :operation, foreign_key: true
      t.timestamps
    end
  end
end
