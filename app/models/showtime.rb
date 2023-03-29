class Showtime < ApplicationRecord
  belongs_to :screen
  belongs_to :movie
end
