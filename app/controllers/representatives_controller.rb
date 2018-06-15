class RepresentativesController < ApplicationController
  def index
  	set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress])	
  	set_query_params_cookies(params[:modality], params[:status], params[:search])
    set_tasks_cookies(params[:today], params[:this_week], params[:this_month])

		@modality_content = cookies[:modality]
		@status_content = cookies[:status]
		@search_content = cookies[:search]
		query_params = [@modality_content, @status_content, @search_content]
		operation = Operation.new
    @operations = operation.fetch_representative_operations(cookies[:sort_param], query_params, current_user)

    @tasks = Task.all
  end
end
