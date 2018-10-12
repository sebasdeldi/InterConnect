class SliController < ApplicationController

  def show
    @operation = Operation.find(params[:operation_id])
    @operation_by_user = OperationsByUser.find_by(operation_id: @operation.id)
    @agent = @operation_by_user.agent
    @shipper = @operation_by_user.shipper
    @consignee = @operation_by_user.consignee
    @cargo_info = FclExwCargoInfoStep.find_by(operation_id: @operation.id)
    @pieces = @cargo_info.pieces
    @booking_info = FclExwBookingInfoStep.find_by(operation_id: @operation.id)
    request_id = FclExwRequestBookingStep.find_by(operation_id: @operation.id).carrier_id
    @sli = Sli.find_by(operation_id: @operation.id)
    unless request_id.nil?
      @steamship = User.find(request_id).company_name
    else
      @steamship = nil
    end
  	@contacted_customer = FclExwInfoRequestedStep.find_by(operation_id: @operation.id).completed
    unless @sli.nil?
      @tariff_groups = @sli.tariff_groups
    else
      @tariff_groups = nil
    end
    respond_to do |format|
      format.html
      format.pdf do
        render template: "sli/sli", pdf: "sli_operation_#{@operation.reference}"   # Excluding ".pdf" extension.
      end
    end
  end

  def new
    @operation = Operation.find_by(secure_id: params[:secure_id])
    existing = Sli.find_by(operation_id: Operation.find_by(secure_id: params[:secure_id]).id)
    if existing
      @sli = existing
    else
      @sli = Sli.new
    end
  end

  def create
    if Sli.find_by(operation_id: Operation.find_by(secure_id: params[:secure_id]).id)
      if Sli.update(sli_params)
        redirect(Operation.find_by(secure_id: params[:secure_id]).id)
      end
    else
      if Sli.create(sli_params)
        redirect(Operation.find_by(secure_id: params[:secure_id]).id)
      end
    end
  end

  def request_sli
  end

  def tariff_group
    sli = Sli.where(operation_id: params[:operation_id]).first_or_create
    params_array = params.to_unsafe_h.to_a.drop(4)[0..-4]
    create_tariff_groups(params_array ,sli)
    redirect(params[:operation_id])
  end

  private
    def redirect(operation_id)
      flash[:notice] = 'Information correctly saved'
      if current_user
        redirect_to operation_path operation_id
      else
        redirect_back(fallback_location: unauthenticated_root_path)
      end
    end

    def create_tariff_groups (params_array, sli)
      TariffGroup.where(sli_id: sli.id).delete_all
      puts '========================================================================'
      puts '========================================================================'
      puts params_array.inspect
      puts '========================================================================'
      puts '========================================================================'
      (0..params_array.length).step(6) do |element|
        unless params_array[element].nil?
          tariff_group = TariffGroup.create!(sli_id: sli.id, code: params_array[element][1], schedule_b: params_array[element+1][1], units: params_array[element+2][1], weight:params_array[element+3][1], value: params_array[element+4][1], eccn: params_array[element+5][1] )
        end
      end
    end

    def sli_params
      params.require(:sli).permit({files: []}, :operation_id)
    end
end
