module TasksHelper
	def fcl_exw_steps_cargo_info_id(operation_id)
		FclExwSteps::CargoInfo.find_by(operation_id: operation_id).id
	end

	def fcl_exw_booking_info_step_id(operation_id)
		FclExwSteps::BookingInfo.find_by(operation_id: operation_id).id
	end

	def info_confirmed_step_id(operation_id)
		CommonSteps::InfoConfirmed.find_by(operation_id: operation_id).id
	end

	def info_requested_step_id(operation_id)
		CommonSteps::InfoRequested.find_by(operation_id: operation_id).id
	end

	def quotation_confirmed_step_id(operation_id)
		CommonSteps::QuotationConfirmed.find_by(operation_id: operation_id).id
	end

	def fcl_exw_request_booking_step_id(operation_id)
		FclExwSteps::RequestBooking.find_by(operation_id: operation_id).id
	end

	def fcl_exw_container_loading_step_id(operation_id)
		FclExwSteps::ContainerLoading.find_by(operation_id: operation_id).id
	end

	def fcl_exw_container_delivery_step_id(operation_id)
		FclExwSteps::ContainerDelivery.find_by(operation_id: operation_id).id
	end

	def lcl_steps_cargo_info_id(operation_id)
		LclSteps::CargoInfo.find_by(operation_id: operation_id).id
	end

	def lcl_booking_info_step_id(operation_id)
		LclSteps::BookingInfo.find_by(operation_id: operation_id).id
	end

	def lcl_request_booking_step_id(operation_id)
		LclSteps::RequestBooking.find_by(operation_id: operation_id).id
	end

	def lcl_container_loading_step_id(operation_id)
		LclSteps::ContainerLoading.find_by(operation_id: operation_id).id
	end

	def lcl_container_delivery_step_id(operation_id)
		LclSteps::ContainerDelivery.find_by(operation_id: operation_id).id
	end
end
