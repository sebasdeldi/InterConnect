class AddCarrierContactIdToFclExwRequestBookingSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :fcl_exw_steps_request_bookings, :carrier_contact_id, :integer
  end
end
