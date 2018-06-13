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
    @task = Task.find params[:id]
    @operation_id = @task.operation_id
  end

  def update
    puts '=================================================================='
    puts params.inspect
    puts '=================================================================='
  end
end
