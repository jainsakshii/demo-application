class Showtime < ApplicationRecord
  belongs_to :screen
  belongs_to :movie
  has_many :seats, dependent: :destroy
  after_create :making_seats
  
  private
  def making_seats
    1.upto(100) do |i|
      Showtime.last.seats.create(availablity_status: true, price: 100)
    end
  end

end
