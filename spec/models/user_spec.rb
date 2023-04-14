require 'rails_helper'

RSpec.describe User, type: :model do
  context "when creating a user" do
    # it {debugger}
    let(:user) { build :user }
    let(:user1) { create :user }
         
    it 'should be valid user with all attributes' do
      expect(user.valid?).to eq(true)
    end

    it 'should have role of newuser if the role field is nil' do
      expect(user1.has_role? :newuser).to eq(true)
    end
  end
  
  context "associations" do
    it { should have_one(:theatre) }
    it { should have_many(:bookings) }
  end 

  # describe "authentication" do
  #   it "finds a user by their email or username or phone" do
  #   expect(User.find_for_database_authentication({login: user.email})).to eq(user)
  #   expect(User.find_for_database_authentication({login: user.username})).to eq(user)
  #   expect(User.find_for_database_authentication({login: user.phone})).to eq(user)
  #   end

  #   it "does not find a user with an incorrect email or username or phone" do
  #     expect(User.find_for_database_authentication({login: "wrongemail@example.com"})).to be_nil
  #     expect(User.find_for_database_authentication({login: "wrongusername"})).to be_nil
  #     expect(User.find_for_database_authentication({login: "1234567890"})).to be_nil
  #   end
  # end

end
