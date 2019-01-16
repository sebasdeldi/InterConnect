module Users
	class Team < ApplicationRecord
		has_many :users
	end
end
