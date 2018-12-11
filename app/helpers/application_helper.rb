module ApplicationHelper

	def agent(operation)
		operation_by_user(operation).agent
	end

	def shipper(operation)
		operation_by_user(operation).shipper
	end

	def consignee(operation)
		operation_by_user(operation).consignee
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

	def contact_names(representative_id)
		user = User.find(representative_id)
		user.contact_first_name + ' ' + user.contact_last_name 
	end

	def operation_by_user(operation)
		OperationsByUser.find_by(operation_id: operation)
	end

	def cargo_info(operation)
		FclExwCargoInfoStep.find_by(operation_id: operation)
	end

	def pieces(operation)
		cargo_info(operation).pieces
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

	def quotation_sell(operation)
		FclExwQuotationSellingStep.find_by(operation_id: operation)
	end

end
