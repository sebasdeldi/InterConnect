module Documents
	class BookingSheetController < ApplicationController
		def show
			@operation = Operation.find(params[:operation_id])
	    respond_to do |format|
	      format.html
	      format.pdf do
	        render template: "documents/booking_sheet/booking_sheet", pdf: "booking_sheet_operation_#{@operation.reference}"   # Excluding ".pdf" extension.
	      end
	   	end
		end
	end
end
