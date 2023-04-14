class Theatre < ApplicationRecord
  validates :name,:contact_number, :venue, presence: true
  has_one :screen, dependent: :destroy
  has_many :movies, through: :screen
  #has_one :theatre_administrator, :class_name => "User", :foreign_key => "user_id"
  belongs_to :theatre_administrator, :class_name => 'User', :foreign_key => 'user_id'
  after_create :making_screen
  
  private
  def making_screen
    build_screen(name:"#{Theatre.last.name} screen").save
  end
end
