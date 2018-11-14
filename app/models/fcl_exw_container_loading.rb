class FclExwContainerLoading < ApplicationRecord
	has_many :tasks
	belongs_to :operation

	def self.confirm_loading(params, current_user)
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		if Operation.find(params[:operation_id]).update(status: 'IN PROGRESS' ,status_message: 'Confirm Container Delivery', current_step: 7)
			FclExwContainerLoading.find_by(operation_id: params[:operation_id]).update(completed: true)
			FclExwOperationMailer.container_loading(agent, op, shipper, current_user).deliver_later
			true
		end
	end
end
