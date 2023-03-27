class Theatre < ApplicationRecord
  validates :name,:contact_number, :venue, presence: true
  has_one :screen, dependent: :destroy
  after_create :making_screen

  private
  def making_screen
    Theatre.last.build_screen(name:"#{Theatre.last.name} screen").save
  end
end
