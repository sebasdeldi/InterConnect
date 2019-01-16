module RecordsLists
	class CustomersController < ApplicationController
	  def index
	    set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress]) 
	    set_query_params_cookies(params[:modality], params[:status], params[:search])
	    query_params = [cookies[:modality], cookies[:status], cookies[:search]]
	    @operations = RecordsLists::Customer.fetch_customers_operations(cookies[:sort_param], query_params, cookies[:customer_id])
	  end
	end
end