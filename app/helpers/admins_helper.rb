module AdminsHelper
	def operations_count(operations)
		if operations.nil? || operations.empty?
			0
		else
			operations.values.inject { |a, b| a + b }
		end
	end
end
