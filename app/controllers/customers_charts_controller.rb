class CustomersChartsController < ApplicationController

	def index
		set_date_range_cookies(params[:day], params[:week], params[:month], params[:year])	
		set_query_params_cookies(params[:modality], params[:customer_id])
		@modality_content = cookies[:modality]
		@customer_id = cookies[:customer_id]
		operation = Operation.new
		#@operations = operation.fetch_charts(cookies[:date_range_param], @modality_content, nil ,nil, @customer_id)
		@operations = operation.fetch_customers_charts(cookies[:date_range_param], @modality_content, @customer_id)
	end

	private
		def set_query_params_cookies(modality, customer_id)
			@modality_content = nil
			@representative_id_content = nil
			cookies.permanent[:modality] = modality
			cookies.permanent[:customer_id] = customer_id
		end
end
