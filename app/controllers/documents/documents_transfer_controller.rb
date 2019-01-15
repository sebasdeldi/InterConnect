module Documents
	class DocumentsTransferController < ApplicationController
	  def send_mail
	  	operation = Operation.find params[:operation_id]
	    FclExwOperationMailer.transfer_documents(params[:additional_comment], operation, current_user).deliver_later
	    redirect_to operation_path operation
	  end
	end
end