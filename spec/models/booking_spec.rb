require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:showtime) }
  end
end
