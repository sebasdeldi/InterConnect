module FclExwBookingInfoStepsHelper
	def pieces_number(operation)
		existing_fcl_cargo_info(operation).pieces_number.to_i
	end

	def existing_fcl_booking_info(operation)
		FclExwBookingInfoStep.existing_fcl_booking_info(operation)
	end

	def existing_fcl_cargo_info(operation)
		FclExwCargoInfoStep.find_by(operation_id: operation)
	end

end
