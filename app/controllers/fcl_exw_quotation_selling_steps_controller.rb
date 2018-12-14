class FclExwQuotationSellingStepsController < ApplicationController
  def confirm
    if params[:commit] == "REQUEST"
      operation = Operation.find params[:operation_id]
      FclExwOperationMailer.issue_profit(operation, current_user).deliver_later
      flash[:notice] = 'Information requested to agent'
    else
      quotation = FclExwQuotationSellingStep.find_by(operation_id: params[:operation_id])
      quotation.update(completed: true, files: params[:files], profit: params[:profit], documentation: params[:documentation], ff: params[:ff], vgm: params[:vgm], inland: params[:inland], others: params[:others], explanation: params[:explanation] )
      Operation.find(params[:operation_id]).update(status: 'IN PROGRESS', status_message:'Request Cargo Info To Shipper', current_step: 2)
      flash[:notice] = 'Information correctly updated'
    end
    redirect_to operation_path params[:operation_id]
  end

  def show
  	@operation = Operation.find params[:id]
  	@quotation = FclExwQuotationSellingStep.find_by(operation_id: params[:id])
  	respond_to do |format|
  		format.html
  	  format.pdf do
  	    render template: "quotation_sell/pdf", pdf: "quotation_sell_operation_#{@operation.reference}"   # Excluding ".pdf" extension.
  	  end
  	end
  end
end
