class Seat < ApplicationRecord
  belongs_to :showtime
  validates :price, presence:true
  #has_one :booking, dependent: :destroy
end
