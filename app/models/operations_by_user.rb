class OperationsByUser < ApplicationRecord
  belongs_to :operation
  belongs_to :representative, class_name: 'User', foreign_key: "representative_id"
  belongs_to :agent, class_name: 'User', foreign_key: "agent_id", optional: true
  belongs_to :shipper, class_name: 'User', foreign_key: "shipper_id", optional: true
  validates :agent_id, :operation_id, presence: true
end
