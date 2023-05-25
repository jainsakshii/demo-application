require 'rails_helper'

RSpec.describe TheatresController, type: :controller do
  # it {debugger}
  let(:user) { create(:user, :admin) }
  before { sign_in user }
  let(:theatre) { create(:theatre, user_id: user.id, theatre_administrator_id: user.id) }
  describe "GET #index" do
    context "when user is authenticated" do
      it "assigns @theatres" do
        get :index
        expect(assigns(:theatres)).to eq([theatre])
      end
    end

    context "when user is not authenticated" do
      before {sign_out user}
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #new" do
   context "when user is authenticated" do
    it "assigns a new theatre to @theatre" do
      get :new
      expect(assigns(:theatre)).to be_a_new(Theatre)
    end
   end
    
   context "when user is not authenticated" do
      before {sign_out user}
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
   
  end

  describe "GET #show" do
   context "when theatre id is valid" do
    it "succeeds" do
      get :show, params: { id: theatre.id }
      expect(response).to be_successful
    end
   end 

   
   context "when theatre id is invalid" do
    it "fails" do 
      expect { get :show, params: {id: 0}}.to raise_error()
    end
  end
  end
end



# require 'rails_helper'

# RSpec.describe TheatresController, type: :controller do
#   describe "GET #index" do
#     context "when user is authenticated" do
#       let(:user) { create(:user) }
#       before { sign_in user }

#       it "assigns @theatres" do
#         theatre = create(:theatre)
#         get :index
#         expect(assigns(:theatres)).to eq([theatre])
#       end

#       it "renders the index template" do
#         get :index
#         expect(response).to render_template(:index)
#       end
#     end

#     context "when user is not authenticated" do
#       it "redirects to the login page" do
#         get :index
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end

#   describe "GET #new" do
#     context "when user is authenticated" do
#       let(:user) { create(:user) }
#       before { sign_in user }

#       it "assigns a new theatre to @theatre" do
#         get :new
#         expect(assigns(:theatre)).to be_a_new(Theatre)
#       end

#       it "renders the new template" do
#         get :new
#         expect(response).to render_template(:new)
#       end
#     end

#     context "when user is not authenticated" do
#       it "redirects to the login page" do
#         get :new
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end

#   describe "POST #create" do
#     let(:user) { create(:user) }
#     before { sign_in user }

#     context "with valid attributes" do
#       it "creates a new theatre" do
#         expect {
#           post :create, params: { theatre: attributes_for(:theatre, user_id: user.id) }
#         }.to change(Theatre, :count).by(1)
#       end

#       it "assigns the theatre to @theatre" do
#         post :create, params: { theatre: attributes_for(:theatre, user_id: user.id) }
#         expect(assigns(:theatre)).to be_a(Theatre)
#         expect(assigns(:theatre)).to be_persisted
#       end

#       it "assigns the theatre admin role to the user" do
#         post :create, params: { theatre: attributes_for(:theatre, user_id: user.id) }
#         expect(user.has_role?(:theatre_admin, assigns(:theatre))).to be(true)
#       end

#       it "redirects to the theatres index page" do
#         post :create, params: { theatre: attributes_for(:theatre, user_id: user.id) }
#         expect(response).to redirect_to(theatres_path)
#       end
#     end

#     context "with invalid attributes" do
#       it "does not create a new theatre" do
#         expect {
#           post :create, params: { theatre: attributes_for(:theatre, name: nil, user_id: user.id) }
#         }.to_not change(Theatre, :count)
#       end

#       it "assigns a new theatre to @theatre" do
#         post :create, params: { theatre: attributes_for(:theatre, name: nil, user_id: user.id) }
#         expect(assigns(:theatre)).to be_a_new(Theatre)
#       end


  
# end
