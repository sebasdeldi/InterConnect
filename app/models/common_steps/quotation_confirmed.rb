module CommonSteps  	
	class QuotationConfirmed < ApplicationRecord
		self.table_name = 'common_steps_quotation_confirmeds'
		has_many :tasks
		belongs_to :operation

		mount_uploaders :files, FileUploader

		def filename
		  File.basename(path)
		end

		def self.confirm_quotation(params, current_user)
			shipper = User.find(params[:shipper_id])
			agent = User.find(params[:agent_id])
			op = Operation.find(params[:operation_id])
			operation =  Operation.find(params[:operation_id])
			step = CommonSteps::QuotationConfirmed.find_by(operation_id: params[:operation_id])
			if params[:commit] == 'ISSUE'
				shipper = User.find(params[:shipper_id])
				agent = User.find(params[:agent_id])
				FclExwOperationMailer.issue_quotation(shipper, current_user, agent, operation).deliver_later
				"Quotation requested to the pricing department"
			else
				if params[:files].present?
					step.update(completed: true, files: params[:files])
					if step.created_at == step.updated_at
						operation.update(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', status_message:'Confirm quotation selling prices', current_step: operation.current_step + 1)
						"Step confirmed, no more reminders will be sent"
					end
				else
					"Please upload a file before sending a confirmation"
				end
			end
		end
	end
end
