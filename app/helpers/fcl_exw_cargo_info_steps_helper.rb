module FclExwCargoInfoStepsHelper
	def progress_percentage(operation_id)
		operation = Operation.find(operation_id)
		((operation.current_step/operation.steps_number)*100).to_s
	end

	def ein(operation)
		operation_by_user(operation).shipper.ein
	end

	def hour(operation, modality)
		if modality == "FCL - EXW"
			existing_fcl_cargo_info(operation).loading_time.hour
		elsif modality == "LCL"
			existing_lcl_cargo_info(operation).dock_hours.hour
		end
	end

	def minute(operation, modality)
		if modality == "FCL - EXW"
			existing_fcl_cargo_info(operation).loading_time.min
		elsif modality == "LCL"
			existing_lcl_cargo_info(operation).dock_hours.min
		end
	end
end
