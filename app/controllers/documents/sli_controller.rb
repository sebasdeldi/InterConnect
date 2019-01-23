module Documents  
  class SliController < ApplicationController

    def show
      @operation = Operation.find(params[:operation_id])
      respond_to do |format|
        format.html
        format.pdf do
          render template: "documents/sli/sli", pdf: "sli_operation_#{@operation.reference}"   # Excluding ".pdf" extension.
        end
      end
    end

    def new
      @operation = Operation.find_by(secure_id: params[:secure_id])
      existing = Documents::Sli.find_by(operation_id: Operation.find_by(secure_id: params[:secure_id]).id)
      if existing
        @sli = existing
      else
        @sli = Documents::Sli.new
      end
    end

    def create
      if Documents::Sli.find_by(operation_id: Operation.find_by(secure_id: params[:secure_id]).id)
        if Documents::Sli.update(sli_params.merge(requested: true))
          redirect(Operation.find_by(secure_id: params[:secure_id]).id)
        end
      else
        if Documents::Sli.create(sli_params.merge(requested: true))
          redirect(Operation.find_by(secure_id: params[:secure_id]).id)
        end
      end
    end

    def request_sli
      op = Operation.find_by(secure_id: params[:secure_id])
      @shipper = Operations::OperationsByUser.find_by(operation_id: op.id).shipper
      FclExwOperationMailer.request_sli(@shipper, current_user, params[:link]).deliver_later
      redirect(op.id, true)
    end

    def tariff_group
      sli = Documents::Sli.where(operation_id: params[:operation_id]).first_or_create
      params_array = params.to_unsafe_h.to_a.drop(4)[0..-4]
      Documents::Sli.create_tariff_groups(params_array ,sli)
      redirect(params[:operation_id])
    end

    private
      def redirect(operation_id, email=false)
        if email
          message = 'Email correctly sent'
        else
          message = 'Information correctly saved'
        end
        flash[:notice] = message
        if current_user
          redirect_to operation_path operation_id
        else
          redirect_back(fallback_location: unauthenticated_root_path)
        end
      end

      def sli_params
        params.require(:sli).permit({files: []}, :operation_id)
      end
  end
end