class Seat < ApplicationRecord
  belongs_to :showtime
  validates :price, :availablity_status, presence:true
  #has_one :booking, dependent: :destroy
end
