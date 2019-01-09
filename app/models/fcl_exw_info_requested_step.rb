class FclExwInfoRequestedStep < ApplicationRecord
	has_many :tasks
	belongs_to :operation

	def self.request_info(params, current_user)
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		step = FclExwInfoRequestedStep.find_by(operation_id: params[:operation_id])
		FclExwOperationMailer.info_request(shipper, current_user, agent, op.secure_id).deliver_later
		if step.created_at == step.updated_at
			op.update(status: 'IN PROGRESS', status_message:'Confirm Cargo Info Received', current_step: op.current_step + 1)
		end
		step.update(completed: true)
		true
	end
end
