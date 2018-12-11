class FclExwInfoConfirmedStep < ApplicationRecord
	has_many :tasks
	belongs_to :operation

	def self.confirm_info(params)
		if Operation.find(params[:operation_id]).update(fcl_exw_info_confirmed: true, status: 'IN PROGRESS' ,status_message: 'Upload Cargo Info To System', current_step: 4)
			FclExwInfoConfirmedStep.find_by(operation_id: params[:operation_id]).update(completed: true)
			true
		end
	end
end
