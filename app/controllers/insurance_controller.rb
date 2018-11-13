class InsuranceController < ApplicationController
  def new
  	@operation = Operation.find_by(secure_id: params[:secure_id])
  	@consignee = OperationsByUser.find_by(operation_id: @operation).consignee
  	@cargo_info = FclExwCargoInfoStep.find_by(operation_id: @operation)
  	@booking_info = FclExwBookingInfoStep.find_by(operation_id: @operation)
  	carrier_id = FclExwRequestBookingStep.find_by(operation_id: @operation).carrier_id
  	unless carrier_id.nil?
  		@carrier = User.find carrier_id
  	else
  		@carrier = nil
  	end
    cargo_descriptions_array = @cargo_info.pieces.select(:commercial_description).to_a
    @cargo_descriptions = []
    cargo_descriptions_array.each do |cargo|
      @cargo_descriptions << cargo.commercial_description
    end
    @cargo_descriptions.join(', ')
    @insurance = Insurance.find_by(operation_id: @operation)
  end

  def view_pdf
    @operation = Operation.find_by(secure_id: params[:secure_id])
    @insurance = Insurance.find_by(operation_id: @operation)
    
    @subtotal = [@insurance.commercial_value, @insurance.freight, @insurance.duties, @insurance.other_costs].compact.sum
    total = [@insurance.voluntary_coverage, @insurance.lost_profit].compact.sum

    @total = @subtotal + total 
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
