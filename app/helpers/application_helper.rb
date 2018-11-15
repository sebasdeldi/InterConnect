module ApplicationHelper
	def agent(operation)
		OperationsByUser.find_by(operation_id: operation).agent
	end

	def shipper(operation)
		OperationsByUser.find_by(operation_id: operation).shipper
	end

	def consignee(operation)
		OperationsByUser.find_by(operation_id: operation).consignee
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

	def quotation(operation)
		FclExwQuotationConfirmedStep.find_by(operation_id: operation)
	end

	def modality
		cookies[:modality]
	end

	def status
		cookies[:status]
	end

	def search
		cookies[:search]
	end

	def customer_id
		cookies[:customer_id]
	end

	def existing_fcl_cargo_info(operation)
		FclExwCargoInfoStep.find_by(operation_id: operation)
	end

	def company_name(customer_id)
		User.find(customer_id).company_name
	end
end
