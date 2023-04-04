class Movie < ApplicationRecord
  validates :name, presence: true
  has_many :showtimes, dependent: :destroy
  has_many :screens, through: :showtimes

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "genre", "id", "name", "updated_at"]
  end

end
