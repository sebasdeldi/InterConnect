module TasksHelper
	def fcl_exw_cargo_info_step_id(operation_id)
		FclExwCargoInfoStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_info_confirmed_step_id(operation_id)
		FclExwInfoConfirmedStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_info_requested_step_id(operation_id)
		FclExwInfoRequestedStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_quotation_confirmed_step_id(operation_id)
		FclExwQuotationConfirmedStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_request_booking_step_id(operation_id)
		FclExwRequestBookingStep.find_by(operation_id: operation_id).id
	end
end
