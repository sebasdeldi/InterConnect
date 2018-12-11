class FclExwContainerDelivery < ApplicationRecord
	has_many :tasks
	belongs_to :operation


	def self.confirm_delivery(params, current_user)
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		if Operation.find(params[:operation_id]).update(status: 'COMPLETED' ,status_message: 'Completed', current_step: 9)
			FclExwContainerDelivery.find_by(operation_id: params[:operation_id]).update(completed: true)
			FclExwOperationMailer.container_delivery(agent, op, shipper, current_user).deliver_later
			true
		end
	end
end
