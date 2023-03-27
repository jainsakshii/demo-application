class Screen < ApplicationRecord
  belongs_to :theatre
  has_many :showtimes, dependent: :destroy
  accepts_nested_attributes_for :showtimes, reject_if: :all_blank, allow_destroy: true
end
