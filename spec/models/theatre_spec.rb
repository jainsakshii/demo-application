require 'rails_helper'

RSpec.describe Theatre, type: :model do
  let(:user) { create(:user, :theatre_administrator) }

  let(:theatre) { create :theatre, user_id: user.id, theatre_administrator_id: user.id }
 
  context "when creating a theatre" do 
    it "should be a valid theatre with all attributes" do
      expect(theatre.valid?).to eq(true)
    end
  end
  
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:contact_number) }
    it { should validate_presence_of(:venue) }
  end
  
  describe "Associations" do
    it { should have_one(:screen).dependent(:destroy) }
    it { should have_many(:movies).through(:screen) }
    it { should belong_to(:theatre_administrator).class_name('User').with_foreign_key('user_id') }
  end
  
end
