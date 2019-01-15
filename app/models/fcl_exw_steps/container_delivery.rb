module FclExwSteps  	
	class ContainerDelivery < ApplicationRecord
		self.table_name = 'fcl_exw_steps_container_deliveries'
		has_many :tasks
		belongs_to :operation


		def self.confirm_delivery(params, current_user)
			shipper = User.find(params[:shipper_id])
			agent = User.find(params[:agent_id])
			op = Operation.find(params[:operation_id])
			step = FclExwSteps::ContainerDelivery.find_by(operation_id: params[:operation_id])
			if step.created_at == step.updated_at
				op.update(status: 'COMPLETED' ,status_message: 'Completed', current_step: op.current_step + 1)
			end

			step.update(completed: true)
			FclExwOperationMailer.container_delivery(agent, op, shipper, current_user).deliver_later
			true
		end
	end
end