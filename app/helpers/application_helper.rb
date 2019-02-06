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
		FclExwSteps::BookingInfo.find_by(operation_id: operation)
	end

	def sli(operation)
		Documents::Sli.find_by(operation_id: operation)
	end

	def invoice(operation)
		Documents::Invoice.find_by(operation_id: operation)
	end

	def quotation(operation)
		CommonSteps::QuotationConfirmed.find_by(operation_id: operation)
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
		FclExwSteps::CargoInfo.find_by(operation_id: operation)
	end

	def company_name(customer_id)
		User.find(customer_id).company_name
	end

	def contact_names(representative_id)
		user = User.find(representative_id)
		user.contact_first_name + ' ' + user.contact_last_name 
	end

	def operation_by_user(operation)
		Operations::OperationsByUser.find_by(operation_id: operation)
	end

	def cargo_info(operation)
		FclExwSteps::CargoInfo.find_by(operation_id: operation)
	end

	def pieces(operation)
		FclExwSteps::Piece.where(fcl_exw_steps_cargo_info_id: cargo_info(operation))
	end

	def steamship(operation)
		carrier_id = FclExwSteps::RequestBooking.find_by(operation_id: operation).carrier_id
		unless carrier_id.nil?
			User.find(carrier_id).company_name
		else
			nil
		end
	end

	def contacted_customer(operation)
		FclExwSteps::InfoRequested.find_by(operation_id: operation).completed
	end

	def quotation_sell(operation)
		Documents::QuotationSelling.find_by(operation_id: operation)
	end

	def booking_order(operation)
		FclExwSteps::RequestBooking.find_by(operation_id: operation)
	end

	def time(time)
		unless time.nil?
			hour = time.hour.to_s 
			min = time.min.to_s
			if hour.length < 2
				hour = '0' + time.hour.to_s
			end
			if min.to_s.length < 2
				min = '0' + time.min.to_s
			end 
			hour + ':' + min
		else
			''
		end
	end

	def default_time(time)
		if time.nil?
			Time.current.change(hour: 0, min: 0)
		else
			Time.current.change(hour: time.hour, min: time.min)
		end
	end
end
