class User < ApplicationRecord
  #attr_accessor :login
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, authentication_keys: [:login]
         # :confirmable
  #validates :name,presence: true

  validates :username, presence: true, uniqueness: true

  attr_accessor :login

  def login
    @login || self.username || self.email || self.phone
  end
  
  #User can have multiple theatre so we might change it to has_many
  has_one :theatre
  has_many :bookings
  after_create :assign_default_role
  
  private

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(phone) ILIKE '%#{login.downcase}%' OR lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end
end
