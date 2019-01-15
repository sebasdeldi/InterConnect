class Task < ApplicationRecord
  belongs_to :fcl_exw_steps_cargo_info, optional: true
  belongs_to :fcl_exw_steps_booking_info, optional: true
  belongs_to :fcl_exw_info_confirmed_step, optional: true
  belongs_to :fcl_exw_info_requested_step, optional: true
  belongs_to :fcl_exw_quotation_confirmed_step, optional: true

  belongs_to :fcl_exw_steps_container_delivery, optional: true

  belongs_to :fcl_exw_container_loading, optional: true

  belongs_to :operation


  validates :note, :due_date, presence: true

  def self.get_data(current_user, due_date)
  	if due_date == 'today'
  		Task.where(operation_id: OperationsByUser.where(representative_id: current_user))
  			.where(status: 0)
  			.where(due_date: Date.today)
  	elsif due_date == 'this_week'
  		Task.where(operation_id: OperationsByUser.where(representative_id: current_user))
  			.where(status: 0)
  			.where('due_date < ?', Date.today + 7.days)
  	elsif due_date == 'this_month'
  		Task.where(operation_id: OperationsByUser.where(representative_id: current_user))
  			.where(status: 0)
  			.where('due_date < ?', Date.today + 30.days)
    elsif due_date == 'all'
      Task.where(operation_id: OperationsByUser.where(representative_id: current_user))
        .where(status: 0)
  	end
 	end

  def self.new_task(params)
    if params[:fcl_exw_cargo_info_step]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_steps_cargo_info_id: params[:fcl_exw_cargo_info_step], operation_id: params[:operation_id] )
    elsif params[:fcl_exw_info_confirmed_step]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_info_confirmed_steps_id: params[:fcl_exw_info_confirmed_step], operation_id: params[:operation_id] )
    elsif params[:fcl_exw_info_requested_step]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_info_requested_steps_id: params[:fcl_exw_info_requested_step], operation_id: params[:operation_id] )
    elsif params[:fcl_exw_quotation_confirmed_step]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_quotation_confirmed_steps_id: params[:fcl_exw_quotation_confirmed_step], operation_id: params[:operation_id] )
    elsif params[:fcl_exw_request_booking_step]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_request_booking_steps_id: params[:fcl_exw_request_booking_step], operation_id: params[:operation_id] )
    elsif params[:fcl_exw_booking_info_steps]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_steps_booking_info_id: params[:fcl_exw_booking_info_steps], operation_id: params[:operation_id] )
    elsif params[:fcl_exw_container_delivery_step]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_container_delivery_id: params[:fcl_exw_container_delivery_step], operation_id: params[:operation_id] )
    elsif params[:fcl_exw_container_loading_step]
      Task.new(note: params[:note], due_date: params[:due_date], fcl_exw_container_loading_id: params[:fcl_exw_container_loading_step], operation_id: params[:operation_id] )
    end
  end
end
