class TasksController < ApplicationController
  def index
  end

  def create
  	task = new_task(params[:task])
    #Task.new(note: params[:task][:note], due_date: params[:task][:due_date], operation_id: params[:task][:operation_id])
  	if task.save
  		flash[:notice] = 'Task saved'
  		redirect_to operation_path params[:task][:operation_id]
  	else
  		flash[:alert] = 'Could not save task'
  		redirect_to operation_path params[:task][:operation_id]
  	end
  end

  def show
    @id = params[:id]
    @task = Task.find params[:id]
    @operation_id = @task.operation_id
  end

  def update
    task = Task.find params[:task][:id]
    task.update(note: params[:task][:note], due_date: params[:task][:due_date], status: params[:task][:status] )
    flash[:notice] = 'Record updated'
    redirect_to operation_path params[:task][:operation_id]
  end

  private
    def new_task(params)
      if params[:fcl_exw_cargo_info_step]
        Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_cargo_info_steps: params[:step_id] )
      elsif params[:fcl_exw_info_confirmed_step]
        Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_info_confirmed_steps: params[:step_id] )
      elsif params[:fcl_exw_info_requested_step]
        Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_info_requested_steps: params[:step_id] )
      elsif params[:fcl_exw_quotation_confirmed_step]
        Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_quotation_confirmed_steps: params[:step_id] )
      end
    end
end