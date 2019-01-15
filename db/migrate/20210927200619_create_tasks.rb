class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :note
      t.string :status, default: '0'
      t.string :subject
      t.date :due_date
      t.references :fcl_exw_steps_info_requested, foreign_key: true
      t.references :fcl_exw_steps_info_confirmed, foreign_key: true
      t.references :fcl_exw_quotation_confirmed_steps, foreign_key: true
      t.references :fcl_exw_steps_cargo_info, foreign_key: true
      t.references :fcl_exw_request_booking_steps, foreign_key: true
      t.references :fcl_exw_steps_booking_info, foreign_key: true

      t.references :fcl_exw_steps_container_delivery, foreign_key: true
      t.references :fcl_exw_steps_container_loading, foreign_key: true

      t.references :operation, foreign_key: true
      t.timestamps
    end
  end
end
