class Task < ApplicationRecord
  belongs_to :operation

  validates :note, :due_date, presence: true

  def self.get_data(current_user)
		Task.where(operation_id: OperationsByUser.where(representative_id: current_user), status: 0)
	end
end
