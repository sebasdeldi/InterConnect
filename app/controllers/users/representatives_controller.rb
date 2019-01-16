module Users
  class RepresentativesController < ApplicationController
    def index
    	set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress])	
    	set_query_params_cookies(params[:modality], params[:status], params[:search])
      set_tasks_cookies(params[:today], params[:this_week], params[:this_month], params[:all])

  		query_params = [cookies[:modality], cookies[:status], cookies[:search]]

      @operations = RecordsLists::Representative.fetch_representative_operations(cookies[:sort_param], query_params, current_user)
      @operations_by_repre =  Operation.where(id: OperationsByUser.where(representative_id: current_user))
      @tasks = Users::Representative.fetch_tasks(params, current_user, cookies[:date_range_param])
      
      set_cookies(params)
    end

    private
      def set_cookies(params)
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
      end
  end
end