module FclExwCargoInfoStepsHelper
	def progress_percentage(operation_id)
		operation = Operation.find(operation_id)
		((operation.current_step/operation.steps_number)*100).to_s
	end

	def existing_fcl_cargo_info(operation)
		FclExwCargoInfoStep.find_by(operation_id: operation)
	end

	def ein(operation)
		OperationsByUser.find_by(operation_id: operation).shipper.ein
	end

	def hour(operation)
		existing_fcl_cargo_info(operation).loading_time.hour
	end

	def minute(operation)
		existing_fcl_cargo_info(operation).loading_time.min
	end
end
