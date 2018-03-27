class Role < ApplicationRecord
	has_many :users
	has_many :functionalities

	validates :name, uniqueness: true
end
