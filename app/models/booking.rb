class Booking < ApplicationRecord
  belongs_to :user
  #belongs_to :seat
  belongs_to :showtime
end
