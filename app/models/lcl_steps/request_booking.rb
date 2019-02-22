module LclSteps  	
	class RequestBooking < ApplicationRecord
		self.table_name = 'lcl_steps_request_bookings'
		has_many :tasks
		belongs_to :operation

		def self.request_booking_website(operation_id, carrier_id)
			op = Operation.find(operation_id)
			booking_step = LclSteps::RequestBooking.find_by(operation_id: operation_id)
			if booking_step.created_at == booking_step.updated_at 
				op.update(status: 'IN PROGRESS', status_message:'Booking order requested ', current_step: op.current_step + 1, status_message:'Fill In Booking Info')
				booking_step.update(updated_at: Time.now )
			end
			LclSteps::RequestBooking.find_by(operation_id: operation_id).update(completed: true, additional_message: '', carrier_id: carrier_id)
			true
		end

		def self.notify(params, current_user)
			shipper = User.find(params[:shipper_id])
			step = LclSteps::CargoInfo.find_by(operation_id: params[:operation_id])
			agent = User.find(params[:agent_id])
			LclOperationMailer.request_booking_notification(agent, step, current_user).deliver_later
			true
		end
	end
end
