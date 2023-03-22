class Theatre < ApplicationRecord
  has_one :screen, dependent: :destroy
  
end
