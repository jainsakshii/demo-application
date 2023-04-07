class Seat < ApplicationRecord
  belongs_to :showtime
  has_one :booking, dependent: :destroy
end
