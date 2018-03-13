class GeneralCargoInfosController < ApplicationController

	before_action :set_up

  def new
  end

  def create
  	general_cargo = GeneralCargoInfo.new(general_cargo_info_strong_params.merge(operation_id: params[:operation_id]))
  	params_array = params.to_unsafe_h.to_a.drop(4)
  	params_array.pop(3)
  	params_array = params_array.each_slice(5).to_a
    if general_cargo.save
      render json: {'success': true}
    else
      errors = general_cargo.errors.messages
      render json: {'success': false, 'tax_id_error': errors[:tax_id], 'packing_list_error': errors[:packing_list],
       'pv_address_error': errors[:pv_address], 'invoice_error': errors[:invoice], 'pieces_number_error': errors[:pieces_number]}
    end
  	params_array.each do |element|
  		piece = Piece.new(general_cargo_info_id: general_cargo.id, weight: element[0][1], height: element[1][1], depth: element[2][1], width: element[3][1], sort: element[4][1])
  	  if piece.save
        render json: {'success': true}
      else
        
      end
    end
  end

  private
  	def set_up
  		@general_cargo_info = GeneralCargoInfo.new
  	end

  	def general_cargo_info_strong_params
  		params.require(:general_cargo_info).permit(:tax_id, :operation_id, :packing_list, :pv_address, :invoice, :pieces_number)
  	end
end
