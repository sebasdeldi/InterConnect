class RepresentativesController < ApplicationController
  def index
  	set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress])	
  	set_query_params_cookies(params[:modality], params[:status], params[:search])
		@modality_content = cookies[:modality]
		@status_content = cookies[:status]
		@search_content = cookies[:search]
		
		operation = Operation.new
		@operations = operation.fetch_operations(cookies[:sort_param], @modality_content, @status_content, @search_content, current_user, nil)
  end


  private
  	def set_sorting_cookies(oldest, newest, more_progress, less_progress)
  		if oldest
  			cookies.permanent[:sort_param] = 'oldest'
  		elsif newest
  			cookies.permanent[:sort_param] = 'newest'
  		elsif more_progress
  			cookies.permanent[:sort_param] = 'more_progress'
  		elsif less_progress
  			cookies.permanent[:sort_param] = 'less_progress'  			
  		end
  	end

  	def set_query_params_cookies(modality, status, search)
  		@modality_content = nil
  		@status_content = nil
  		@search_content = nil
  		cookies.permanent[:modality] = modality
  		cookies.permanent[:status] = status
  		cookies.permanent[:search] = search
  	end
end
