class UsersRelationship < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :related, class_name: 'User', optional: true
end
