module FclExwCargoInfosHelper
	def progress_percentage(operation_id)
		operation = Operation.find(operation_id)
		((operation.current_step/operation.steps_number)*100).to_s
	end
end
