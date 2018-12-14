class FclExwRequestBookingStep < ApplicationRecord
	has_many :tasks
	belongs_to :operation

	def self.request_booking(params, current_user)
		shipper = User.find(params[:shipper_id])
		op = Operation.find(params[:operation_id])
		step = FclExwCargoInfoStep.find_by(operation_id: params[:operation_id])
		agent = User.find(params[:agent_id])
		operation = [op, step]
		carrier = User.find(params[:carrier_contact_id])
		additional_message = params[:additional_message]
		FclExwOperationMailer.request_booking(shipper, operation, carrier, additional_message, current_user).deliver_later
		if op.update(status: 'IN PROGRESS', status_message:'Booking order sent to ', current_step: 6, status_message:'Fill In Booking Info')
			FclExwRequestBookingStep.find_by(operation_id: params[:operation_id]).update(completed: true, additional_message: params[:additional_message], carrier_id: params[:carrier_id], carrier_contact_id: params[:carrier_contact_id])
			true
		end
	end

	def self.notify(params, current_user)
		shipper = User.find(params[:shipper_id])
		step = FclExwCargoInfoStep.find_by(operation_id: params[:operation_id])
		agent = User.find(params[:agent_id])
		carrier = User.find(params[:carrier_contact_id])
		FclExwOperationMailer.request_booking_notification(agent, step, carrier, current_user).deliver_later
		true
	end
end
