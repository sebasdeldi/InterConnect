class InsuranceController < ApplicationController
  def new
  	@operation = Operation.find_by(secure_id: params[:secure_id])
  end

  def view_pdf
    @operation = Operation.find_by(secure_id: params[:secure_id])
    respond_to do |format|
      format.html
      format.pdf do
        render template: "insurance/view_pdf", pdf: "insurance_#{@operation.reference}"   # Excluding ".pdf" extension.
      end
    end
  end

  def send_info
    operation = Operation.find(params[:operation_id])
    FclExwOperationMailer.send_insurance_info(request.base_url+insurance_form_path(operation.secure_id), operation, current_user).deliver_later
    redirect(params[:operation_id], 'email')
  end

  def create
    operation = Operation.find(params[:insurance][:operation_id])
    @insurance = Insurance.find_by(operation_id: operation)
    @insurance.update(insurance_params)
    redirect(params[:insurance][:operation_id], 'saved')
  end

  private
		def insurance_params
			params.require(:insurance).permit(:name, :email, :phone, :address, :city, :state, :zip, :country,
				:modality, :origin_address, :origin_city, :origin_state, :origin_zip_code, :origin_country, :destination, :incoterm, :etd, :carrier, :commodities, :marks, :commercial_value,
				:freight, :duties, :other_costs, :voluntary_coverage, :lost_profit, :operation_id)
		end

    def redirect(operation_id, action)
      if action == "saved"
        message = 'Information correctly saved'
      elsif action == "email"
        message = "Email correctly sent"
      end

      flash[:notice] = message
      if current_user
        redirect_to operation_path operation_id
      else
        redirect_back(fallback_location: unauthenticated_root_path)
      end
    end
end
