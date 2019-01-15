module Documents	
	class TariffGroup < ApplicationRecord
		belongs_to :sli, optional: true

	end
end
