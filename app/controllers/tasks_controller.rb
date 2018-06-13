class TasksController < ApplicationController
  def index
  end

  def create
  	task = Task.new(note: params[:task][:note], due_date: params[:task][:due_date], operation_id: params[:task][:operation_id])
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
end
