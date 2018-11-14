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
		else
			'Haz/S Prop/Bonded-'+ (iteration+1).to_s
		end
	end

	def breadcrumb_selector
		redirect = []
		if is_admin?
			redirect = ['Operation Records List', general_records_path]
		elsif is_leader?
			redirect = ['Main Page', authenticated_root_path]
		elsif is_representative?
			redirect = ['Operation Records List', representative_path]
		end
	end

	def quotation(operation_id)
		FclExwQuotationConfirmedStep.find_by(operation_id: operation_id)
	end
end
