class FclExwQuotationConfirmedStep < ApplicationRecord
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
		if params[:commit] == 'ISSUE'
			shipper = User.find(params[:shipper_id])
			agent = User.find(params[:agent_id])
			FclExwOperationMailer.issue_quotation(shipper, current_user, agent, operation).deliver_later
			"Quotation requested to the pricing department"
		else
			if params[:files].present?
				if operation.update(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', status_message:'Request Cargo Info To Shipper', current_step: 1)
					FclExwQuotationConfirmedStep.find_by(operation_id: params[:operation_id]).update(completed: true, files: params[:files])
					"Step confirmed, no more reminders will be sent"
				end
			else
				"Please upload a file before sending a confirmation"
			end
		end
	end
end
