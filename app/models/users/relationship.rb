module Users
	class Relationship < ApplicationRecord
		self.table_name = 'users_relationships'
		belongs_to :user, optional: true
	end
end