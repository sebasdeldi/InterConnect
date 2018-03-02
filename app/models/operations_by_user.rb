class OperationsByUser < ApplicationRecord
  belongs_to :user
  belongs_to :operation

  validates :user_id, :operation_id, presence: true
end
