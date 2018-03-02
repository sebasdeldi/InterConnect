class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :operations_by_users
  belongs_to :roles , optional: true

  scope :agents, -> { where(role_id: Role.find_by(name: 'agent').id) }
end
