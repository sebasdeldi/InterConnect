class GeneralRecordsController < ApplicationController
  def index
  	set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress])	
  	set_query_params_cookies(params[:modality], params[:status], params[:search])
		@modality_content = cookies[:modality]
		@status_content = cookies[:status]
		@search_content = cookies[:search]
		operation = Operation.new
		@operations = operation.fetch_operations(cookies[:sort_param], @modality_content, @status_content, @search_content, nil, nil)
  end
end
