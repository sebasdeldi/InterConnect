class Task < ApplicationRecord
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
  	end
 	end
end
