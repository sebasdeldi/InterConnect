module CommonSteps  	
	class InfoConfirmed < ApplicationRecord
		self.table_name = 'common_steps_info_confirmeds'
		has_many :tasks
		belongs_to :operation

		def self.confirm_info(params)
			op = Operation.find(params[:operation_id])
			step = CommonSteps::InfoConfirmed.find_by(operation_id: params[:operation_id])
			if step.created_at == step.updated_at 
				op.update(fcl_exw_info_confirmed: true, status: 'IN PROGRESS' ,status_message: 'Upload Cargo Info To System', current_step: op.current_step + 1)
			end

			step.update(completed: true)
			true		
		end
	end
end