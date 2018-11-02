class RepresentativesController < ApplicationController
  def index
  	set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress])	
  	set_query_params_cookies(params[:modality], params[:status], params[:search])
    set_tasks_cookies(params[:today], params[:this_week], params[:this_month], params[:all])

		@modality_content = cookies[:modality]
		@status_content = cookies[:status]
		@search_content = cookies[:search]
    date_range_param = cookies[:date_range_param]

		query_params = [@modality_content, @status_content, @search_content]
		operation = Operation.new
    @operations = operation.fetch_representative_operations(cookies[:sort_param], query_params, current_user)
    @operations_by_repre =  Operation.where(id: OperationsByUser.where(representative_id: current_user))
    @task_subject = Task.distinct.pluck(:subject)

    #handling tab behaviour by cookies
    if params[:operations].present?
      cookies.permanent[:redirect_tab] = 'operations_tab'
    end

    if params[:operation_id].present?
      cookies.permanent[:operation_task_search] = params[:operation_id]  
    end

    if params[:task_subject].present?
      cookies.permanent[:operation_task_subject] = params[:task_subject]  
    end


    if ((params[:operation_id] == 'ALL' || params[:operation_id].nil?) && (params[:task_subject] == 'ALL' || params[:task_subject].nil?))
      @tasks = Task.get_data(current_user, date_range_param)
    elsif ((params[:operation_id] != 'ALL' && !params[:operation_id].nil?) && (params[:task_subject] == 'ALL' || params[:task_subject].nil?))
      @tasks = Task.get_data(current_user, date_range_param).where(operation_id: params[:operation_id])
    elsif ((params[:operation_id] == 'ALL' || params[:operation_id].nil?) && (params[:task_subject] != 'ALL' && !params[:task_subject].nil?))
      @tasks = Task.get_data(current_user, date_range_param).where(subject: params[:task_subject])
    elsif ((params[:operation_id] != 'ALL' || !params[:operation_id].nil?) && (params[:task_subject] != 'ALL' && !params[:task_subject].nil?))
      @tasks = Task.get_data(current_user, date_range_param).where(subject: params[:task_subject], operation_id: params[:operation_id])
    end
  end
end
