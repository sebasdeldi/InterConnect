class CustomersChartsController < ApplicationController

	def index
		set_sorting_cookies(params[:day], params[:week], params[:month], params[:year])	
		set_query_params_cookies(params[:modality], params[:customer_id])
		@modality_content = cookies[:modality]
		@customer_id = cookies[:customer_id]
		operation = Operation.new
		@operations = operation.fetch_charts(cookies[:date_range_param], @modality_content, nil ,nil, @customer_id)
	end

	private
		def set_sorting_cookies(day, week, month, year)
			if day
				cookies.permanent[:date_range_param] = 'day'
			elsif week
				cookies.permanent[:date_range_param] = 'week'
			elsif month
				cookies.permanent[:date_range_param] = 'month'
			elsif year
				cookies.permanent[:date_range_param] = 'year' 
			else 		
				cookies.permanent[:date_range_param] = 'day'
			end
		end

		def set_query_params_cookies(modality, customer_id)
			@modality_content = nil
			@representative_id_content = nil
			cookies.permanent[:modality] = modality
			cookies.permanent[:customer_id] = customer_id
		end
end
