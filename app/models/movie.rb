class Movie < ApplicationRecord
  include Discard::Model
  validates :name, :genre, :description, presence: true
  has_many :showtimes, dependent: :destroy
  has_many :screens, through: :showtimes
  has_one_attached :movie_poster, dependent: :destroy
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "genre", "id", "name", "updated_at"]
  end

end
