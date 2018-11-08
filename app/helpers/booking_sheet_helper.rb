module BookingSheetHelper

	def operation_by_user(operation)
		OperationsByUser.find_by(operation_id: operation)
	end

	def agent(operation)
		operation_by_user(operation).agent
	end

	def shipper(operation)
		operation_by_user(operation).shipper
	end

	def consignee(operation)
		operation_by_user(operation).shipper
	end

	def cargo_info(operation)
		FclExwCargoInfoStep.find_by(operation_id: operation)
	end

	def pieces(operation)
		cargo_info(operation).pieces
	end

	def booking_info(operation)
		FclExwBookingInfoStep.find_by(operation_id: operation)
	end

	def sli(operation)
		Sli.find_by(operation_id: operation)
	end

	def invoice(operation)
		Invoice.find_by(operation_id: operation)
	end

	def self_propelled_task(operation)
		Task.find_by(operation_id: operation, subject: 'Self Propelled Docummentation')
	end

	def steamship(operation)
		carrier_id = FclExwRequestBookingStep.find_by(operation_id: operation).carrier_id
		unless carrier_id.nil?
			User.find(carrier_id).company_name
		else
			nil
		end
	end

	def contacted_customer(operation)
		FclExwInfoRequestedStep.find_by(operation_id: operation).completed
	end
end
