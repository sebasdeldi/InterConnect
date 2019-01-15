module FclExwBookingInfoStepsHelper
	def pieces_number(operation)
		existing_fcl_cargo_info(operation).pieces_number.to_i
	end

	def existing_fcl_booking_info(operation)
		FclExwSteps::FclExwBookingInfoStep.existing_fcl_booking_info(operation)
	end

end
