class RepresentativesController < ApplicationController
  def index
  	set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress])	
  	set_query_params_cookies(params[:modality], params[:status], params[:search])
		@modality_content = cookies[:modality]
		@status_content = cookies[:status]
		@search_content = cookies[:search]
		query_params = [@modality_content, @status_content, @search_content]
		operation = Operation.new
    @operations = operation.fetch_representative_operations(cookies[:sort_param], query_params, current_user)
  end


  private
  	def set_query_params_cookies(modality, status, search)
  		@modality_content = nil
  		@status_content = nil
  		@search_content = nil
  		cookies.permanent[:modality] = modality
  		cookies.permanent[:status] = status
  		cookies.permanent[:search] = search
  	end
end
