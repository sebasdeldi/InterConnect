class CustomersChartsController < ApplicationController
	def index
		set_date_range_cookies(params[:day], params[:week], params[:month], params[:year])	
		set_query_params_cookies(params[:modality], nil, nil, params[:customer_id])
		@operations = CustomersChart.fetch_customers_charts(cookies[:date_range_param], cookies[:modality], cookies[:customer_id])
	end

end
