module InsuranceHelper

	def carrier(operation)
		carrier_id = FclExwRequestBookingStep.find_by(operation_id: operation).carrier_id
		unless carrier_id.nil?
			User.find carrier_id
		else
			nil
		end
	end

	def cargo_descriptions(operation)
		cargo_info = FclExwCargoInfoStep.find_by(operation_id: operation)
		cargo_descriptions_array = cargo_info.pieces.select(:commercial_description).to_a
		cargo_descriptions = []
		cargo_descriptions_array.each do |cargo|
		  cargo_descriptions << cargo.commercial_description
		end
		cargo_descriptions.join(', ')
	end

	def insurance(operation)
		Insurance.find_by(operation_id: operation)
	end

	def subtotal(operation)
		[insurance(operation).commercial_value, insurance(operation).freight, insurance(operation).duties, insurance(operation).other_costs].compact.sum
	end

	def total(operation)
		[insurance(operation).voluntary_coverage, insurance(operation).lost_profit].compact.sum + subtotal(operation)
	end
end
