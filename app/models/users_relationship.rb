class UsersRelationship < ApplicationRecord
	belongs_to :user
	belongs_to :related, class_name: 'User'
end
