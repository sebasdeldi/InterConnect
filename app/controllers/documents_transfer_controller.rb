class DocumentsTransferController < ApplicationController
  def send_mail
  	operation = Operation.find params[:operation_id]
    FclExwOperationMailer.transfer_documents(operation, current_user).deliver_later
  end
end
