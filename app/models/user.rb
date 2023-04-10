class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
         # :confirmable
  #validates :name,presence: true
  #User can have multiple theatre so we might change it to has_many
  has_one :theatre
  has_many :bookings
  after_create :assign_default_role
   
  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end
end
