class BookingSheetController < ApplicationController
	def show
		@operation = Operation.find(params[:operation_id])
		@operation_by_user = OperationsByUser.find_by(operation_id: params[:operation_id])
		@agent = @operation_by_user.agent
		@shipper = @operation_by_user.shipper
		@consignee = @operation_by_user.consignee
		@cargo_info = FclExwCargoInfoStep.find_by(operation_id: @operation.id)
		@pieces = @cargo_info.pieces
		@booking_info = FclExwBookingInfoStep.find_by(operation_id: @operation.id)

		@contacted_customer = FclExwInfoRequestedStep.find_by(operation_id: @operation.id).completed
	    respond_to do |format|
	      format.html
	      format.pdf do
	        render template: "booking_sheet/booking_sheet", pdf: "booking_sheet_operation_#{@operation.reference}"   # Excluding ".pdf" extension.
	      end
	    end
	  end
end
