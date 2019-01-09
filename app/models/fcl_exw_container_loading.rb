class FclExwContainerLoading < ApplicationRecord
	has_many :tasks
	belongs_to :operation

	def self.confirm_loading(params, current_user)
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		step = FclExwContainerLoading.find_by(operation_id: params[:operation_id])
		if step.created_at == step.updated_at
			op.update(status: 'IN PROGRESS' ,status_message: 'Confirm Container Delivery', current_step: op.current_step + 1)
		end

		step.update(completed: true)
		FclExwOperationMailer.container_loading(agent, op, shipper, current_user).deliver_later
		true
	end
end
