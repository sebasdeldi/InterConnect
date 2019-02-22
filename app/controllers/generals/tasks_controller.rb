module Generals  
  class TasksController < ApplicationController
    def create
    	task = Generals::Task.new_task(params[:task])
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
      @task = Generals::Task.find params[:id]
      @operation_id = @task.operation_id
      @operation = Operation.find(@operation_id)
    end

    def update
      task = Generals::Task.find params[:task][:id]
      task.update(note: params[:task][:note], due_date: params[:task][:due_date], status: params[:task][:status] )
      flash[:notice] = 'Record updated'
      redirect_to operation_path params[:task][:operation_id]
    end
  end
end