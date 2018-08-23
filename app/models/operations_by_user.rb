class OperationsByUser < ApplicationRecord
  belongs_to :operation
  belongs_to :representative, class_name: 'User', foreign_key: "representative_id"
  belongs_to :agent, class_name: 'User', foreign_key: "agent_id", optional: true
  belongs_to :shipper, class_name: 'User', foreign_key: "shipper_id", optional: true
  validates :agent_id, :operation_id, presence: true

  # fields is an array conteining [ reference, modality, strong_params_for_representatives, current_user, pieces_number ]

  def create_for_representatives(fields)
		operation = create_operation(fields[1], fields[0], fields[4], fields[5], fields[6])
		@operations_by_user = OperationsByUser.create(fields[2].merge(operation_id: operation.id, representative_id: fields[3].id))
  end

  def create_for_agents(modality, strong_params_for_agents, current_user)
		operation = Operation.create(status: 'IN PROGRESS', status_message:'Confirm quotation', modality: modality)
    create_steps(operation)
		@operations_by_user = OperationsByUser.create(strong_params_for_agents.merge(operation_id: operation.id, agent_id: current_user.id))
  end

  private
  	def create_operation(modality, reference, pieces_number, po_number, reference_number)
  		steps_number = 1
  		if modality == "FCL - EXW"
  			steps_number = 6
  			#TODO add other modality cases
  		end
  		operation = Operation.create(reference: reference, status: 'IN PROGRESS', status_message:'Confirm quotation', 
        modality: modality, steps_number: steps_number, current_step: 0, pieces_number: pieces_number, po_number: po_number, reference_number: reference_number)
      create_steps(operation)
      operation
    end

    def create_steps(operation)
      FclExwInfoConfirmedStep.create(operation: operation)
      FclExwQuotationConfirmedStep.create(operation: operation)
      FclExwInfoRequestedStep.create(operation: operation)
      FclExwRequestBookingStep.create(operation: operation)
      cargo_info = FclExwCargoInfoStep.new(operation: operation)
      cargo_info.save(validate: false)
      booking_info = FclExwBookingInfoStep.new(operation: operation)
      booking_info.save(validate: false)
    end
end
