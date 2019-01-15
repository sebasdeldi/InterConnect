module FclExwSteps  	
	class FclExwRequestBookingStep < ApplicationRecord
		has_many :tasks
		belongs_to :operation

		def self.request_booking(params, current_user)
			shipper = User.find(params[:shipper_id])
			op = Operation.find(params[:operation_id])
			step = FclExwSteps::CargoInfo.find_by(operation_id: params[:operation_id])
			booking_step = FclExwSteps::FclExwRequestBookingStep.find_by(operation_id: params[:operation_id])
			agent = User.find(params[:agent_id])
			operation = [op, step]
			carrier = User.find(params[:carrier_contact_id])
			additional_message = params[:additional_message]
			FclExwOperationMailer.request_booking(shipper, operation, carrier, additional_message, current_user).deliver_later
			if booking_step.created_at == booking_step.updated_at 
				op.update(status: 'IN PROGRESS', status_message:'Booking order requested ', current_step: op.current_step + 1, status_message:'Fill In Booking Info')
				booking_step.update(updated_at: Time.now )
			end
			FclExwSteps::FclExwRequestBookingStep.find_by(operation_id: params[:operation_id]).update(completed: true, additional_message: params[:additional_message], carrier_id: params[:carrier_id], carrier_contact_id: params[:carrier_contact_id])
			true
		end

		def self.request_booking_website(operation_id, carrier_id)
			op = Operation.find(operation_id)
			booking_step = FclExwSteps::FclExwRequestBookingStep.find_by(operation_id: operation_id)
			if booking_step.created_at == booking_step.updated_at 
				op.update(status: 'IN PROGRESS', status_message:'Booking order requested ', current_step: op.current_step + 1, status_message:'Fill In Booking Info')
				booking_step.update(updated_at: Time.now )
			end
			FclExwSteps::FclExwRequestBookingStep.find_by(operation_id: operation_id).update(completed: true, additional_message: '', carrier_id: carrier_id, carrier_contact_id: 0)
			true
		end

		def self.notify(params, current_user)
			shipper = User.find(params[:shipper_id])
			step = FclExwSteps::CargoInfo.find_by(operation_id: params[:operation_id])
			agent = User.find(params[:agent_id])
			carrier = User.find(params[:carrier_contact_id])
			FclExwOperationMailer.request_booking_notification(agent, step, carrier, current_user).deliver_later
			true
		end
	end
end
