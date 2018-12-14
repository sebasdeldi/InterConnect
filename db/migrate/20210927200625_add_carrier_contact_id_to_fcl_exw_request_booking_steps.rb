class AddCarrierContactIdToFclExwRequestBookingSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :fcl_exw_request_booking_steps, :carrier_contact_id, :integer
  end
end
