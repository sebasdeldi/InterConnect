class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true
  validates :email, :company_name, :phone_number, presence: true


  has_many :agent, class_name: 'OperationsByUser'
  has_many :shipper, class_name: 'OperationsByUser'
  has_many :representative, class_name: 'OperationsByUser'
  has_many :pricing_representatives, class_name: 'OperationsByUser'


  belongs_to :roles , optional: true

  scope :agents, -> { where(role_id: Role.find_by(name: 'agent').id) }
  scope :representatives, -> { where(role_id: Role.find_by(name: 'representative').id) }
  scope :shippers, -> { where(role_id: Role.find_by(name: 'shipper').id) }
  scope :pricing_representatives, -> { where(role_id: Role.find_by(name: 'pricing_representatives').id) }


end
