class Task < ApplicationRecord
  belongs_to :operation

  validates :note, :due_date, presence: true
end
