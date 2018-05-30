class OperationsByUser < ApplicationRecord
  belongs_to :operation
  belongs_to :representative, class_name: 'User', foreign_key: "representative_id"
  belongs_to :agent, class_name: 'User', foreign_key: "agent_id", optional: true
  belongs_to :shipper, class_name: 'User', foreign_key: "shipper_id", optional: true
  validates :agent_id, :operation_id, presence: true

  def create_for_representatives(modality, strong_params_for_representatives, current_user)
		operation = create_operation(modality)
		@operations_by_user = OperationsByUser.create(strong_params_for_representatives.merge(operation_id: operation.id, representative_id: current_user.id))
  end

  def create_for_agents(modality, strong_params_for_agents, current_user)
		operation = Operation.create(status: 'IN PROGRESS', status_message:'Initializing operation', modality: modality)
		@operations_by_user = OperationsByUser.create(strong_params_for_agents.merge(operation_id: operation.id, agent_id: current_user.id))
  end

  private
  	def create_operation(modality)
  		steps_number = 1
  		if modality == "FCL - EXW"
  			steps_number = 4
  			#TODO add other modality cases
  		end
  		operation = Operation.create(status: 'IN PROGRESS', status_message:'Initializing operation', modality: modality, steps_number: steps_number, current_step: 0)
  	end
end
