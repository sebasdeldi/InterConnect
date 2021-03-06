module OperationsHelper
	def is_active_sort_method?(sort_param)
		if cookies[:sort_param] == sort_param
			'is-dark'
		else
			''
		end
	end

	def is_active_date_range?(date_range_param)
		if cookies[:date_range_param] == date_range_param
			'is-dark'
		else
			''
		end
	end

	def doc_name(iteration, type=nil)
		if type == 'quotation'
			'Quotation Doc-'+ (iteration+1).to_s 
		elsif type == 'sell-quotation'
			'Sold Support-'+ (iteration+1).to_s 
		else
			'Haz/S Prop/Bonded-'+ (iteration+1).to_s
		end
	end

	def breadcrumb_selector
		redirect = []
		if is_admin?
			redirect = ['Operation Records List', records_lists_general_path]
		elsif is_leader?
			redirect = ['Main Page', authenticated_root_path]
		elsif is_representative?
			redirect = ['Operation Records List', users_representative_path]
		end
	end

	def operation_secure_id(operation)
		operation.secure_id
	end

	def operation(operation_id)
		if operation_id.nil?
			nil
		else
			Operation.find operation_id
		end
	end

	def carriers
		User.carriers
	end

	def fcl_exw_container_loading_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0',fcl_exw_steps_container_loading_id: FclExwSteps::ContainerLoading.find_by(operation_id: operation))
	end

	def fcl_exw_container_delivery_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0',fcl_exw_steps_container_delivery_id: FclExwSteps::ContainerDelivery.find_by(operation_id: operation))
	end

	def booking_info_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0',fcl_exw_steps_booking_info_id: FclExwSteps::BookingInfo.find_by(operation_id: operation))
	end

	def request_booking_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0',fcl_exw_steps_request_bookings_id: FclExwSteps::RequestBooking.find_by(operation_id: operation))
	end

	def quotation_confirmed_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0',common_steps_quotation_confirmed_id: CommonSteps::QuotationConfirmed.find_by(operation_id: operation))
	end

	def tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0')
	end

	def cargo_info_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0', fcl_exw_steps_cargo_info_id: FclExwSteps::CargoInfo.find_by(operation_id: operation))
	end

	def info_confirmed_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0', common_steps_info_confirmed_id: CommonSteps::InfoConfirmed.find_by(operation_id: operation))
	end

	def info_requested_tasks(operation)
		Generals::Task.where(operation_id: operation, status: '0', common_steps_info_requested_id: CommonSteps::InfoRequested.find_by(operation_id: operation))
	end
end
