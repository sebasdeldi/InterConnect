module OperationsHelper
	def is_active_sort_method? (sort_param)
		if cookies[:sort_param] == sort_param
			'is-dark'
		else
			''
		end
	end

	def is_active_date_range? (date_range_param)
		if cookies[:date_range_param] == date_range_param
			'is-dark'
		else
			''
		end
	end
end
