module Documents	
	class InvoiceController < ApplicationController

		def new
		  @operation = Operation.find_by(secure_id: params[:secure_id])
		  existing = Documents::Invoice.find_by(operation_id: Operation.find_by(secure_id: params[:secure_id]).id)
		  if existing
		    @invoice = existing
		  else
		    @invoice = Documents::Sli.new
		  end
		end

		def create
		  if Documents::Invoice.find_by(operation_id: Operation.find_by(secure_id: params[:secure_id]).id)
		    if Documents::Invoice.update(invoice_params.merge(requested: true))
		      redirect(Operation.find_by(secure_id: params[:secure_id]).id)
		    end
		  else
		    if Documents::Invoice.create(invoice_params.merge(requested: true))
		      redirect(Operation.find_by(secure_id: params[:secure_id]).id)
		    end
		  end
		end

		def request_invoice
		  op = Operation.find_by(secure_id: params[:secure_id])
		  @shipper = Operations::OperationsByUser.find_by(operation_id: op.id).shipper
		  FclExwOperationMailer.request_invoice(@shipper, current_user, params[:link]).deliver_later
		  redirect(op.id, true)
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

			def invoice_params
			  params.require(:invoice).permit({files: []}, :operation_id)
			end
	end
end