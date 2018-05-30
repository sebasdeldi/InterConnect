=beginclass GeneralCargoInfosController < ApplicationController

	before_action :set_up

  def new
  end

  def create
    if existing_general_cargo(params[:operation_id]).nil?
      create_general_cargo params[:operation_id]
    else
      existing_general_cargo(params[:operation_id]).destroy
      create_general_cargo params[:operation_id]
    end
  end





  private
  	def set_up
  		@general_cargo_info = GeneralCargoInfo.new
  	end

  	def general_cargo_info_strong_params
  		params.require(:general_cargo_info).permit(:tax_id, :operation_id, :packing_list, :pv_address, :invoice, :pieces_number)
  	end

    def create_pieces_for_general_cargo (params_array, general_cargo)
      params_array.each do |element|
        piece = Piece.new(general_cargo_info_id: general_cargo.id, weight: element[0][1], height: element[1][1], depth: element[2][1], width: element[3][1], sort: element[4][1])
        unless piece.save
          error_trigger = true
          general_cargo.destroy
        else
          error_trigger = false
        end
      end
    end

    def existing_general_cargo (operation_id)
      GeneralCargoInfo.find_by(operation_id: operation_id)
    end

    def create_general_cargo (operation_id)
      general_cargo = GeneralCargoInfo.new(general_cargo_info_strong_params.merge(operation_id: operation_id))
      params_array = params.to_unsafe_h.to_a.drop(4)
      params_array.pop(3)
      params_array = params_array.each_slice(5).to_a
      errors_json = {"errors" => []}
      error_trigger = false

      if general_cargo.save

        create_pieces_for_general_cargo(params_array, general_cargo)

        if error_trigger
          errors_json['errors'].push({'piece_error' => true}) 
        else
          errors_json["errors"].push({'operation_id' => operation_id ,'piece_error' => false})
        end

      else
        errors = general_cargo.errors.messages
        errors_json["errors"].push({'success' => false, 'tax_id_error' => errors[:tax_id], 'packing_list_error' => errors[:packing_list],'pv_address_error' => errors[:pv_address], 'invoice_error' => errors[:invoice], 'pieces_number_error' => errors[:pieces_number]})
      end

      render json: errors_json
    end
end
=end