class Showtime < ApplicationRecord
  #validates :name, :schedule, presence: true
  belongs_to :screen
  belongs_to :movie
  has_many :seats, dependent: :destroy
  has_many :bookings, dependent: :destroy
  after_create :making_seats
  
  private
  def making_seats
    1.upto(10) do |i|
      seats.create(name: "A#{i}", availablity_status: true, price: 100)
    end
  end

end
