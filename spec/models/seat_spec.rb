require 'rails_helper'

RSpec.describe Seat, type: :model do
  # it {debugger}
  # let(:showtime) {create :showtime, name: "Morning", schedule: "14:00", scheduleDate: "15-04-2023" }
  # let(:seat) { create :seat, availablity_status: true}
  describe "Associations" do
    it { should belong_to(:showtime) }
  end

  # context "when creating a seat" do 
  #   it "should be valid seat" do 
  #     expect(seat.valid?).to eq(true)
  #   end
  # end
end
