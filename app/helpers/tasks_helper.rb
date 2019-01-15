module TasksHelper
	def fcl_exw_steps_cargo_info_id(operation_id)
		FclExwSteps::CargoInfo.find_by(operation_id: operation_id).id
	end

	def fcl_exw_booking_info_step_id(operation_id)
		FclExwSteps::BookingInfo.find_by(operation_id: operation_id).id
	end

	def fcl_exw_info_confirmed_step_id(operation_id)
		FclExwSteps::FclExwInfoConfirmedStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_info_requested_step_id(operation_id)
		FclExwSteps::FclExwInfoRequestedStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_quotation_confirmed_step_id(operation_id)
		FclExwSteps::FclExwQuotationConfirmedStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_request_booking_step_id(operation_id)
		FclExwSteps::FclExwRequestBookingStep.find_by(operation_id: operation_id).id
	end

	def fcl_exw_container_loading_step_id(operation_id)
		FclExwSteps::FclExwContainerLoading.find_by(operation_id: operation_id).id
	end

	def fcl_exw_container_delivery_step_id(operation_id)
		FclExwSteps::ContainerDelivery.find_by(operation_id: operation_id).id
	end
end
