module SliHelper
	def tariff_groups(operation)
		sli = sli(operation)
		unless sli.nil?
		  sli.tariff_groups
		else
		  nil
		end
	end
end
