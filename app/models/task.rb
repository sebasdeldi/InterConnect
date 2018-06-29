class Task < ApplicationRecord
  belongs_to :fcl_exw_cargo_info_step, optional: true
  belongs_to :fcl_exw_info_confirmed_step, optional: true
  belongs_to :fcl_exw_info_requested_step, optional: true
  belongs_to :fcl_exw_quotation_confirmed_step, optional: true
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
end
