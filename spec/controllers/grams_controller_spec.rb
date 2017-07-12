# firehost track 5, lesson 5 - file created 10 jul 17 for writing first test

require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

# added 11 jul 17 for adding gram in db, connecting a gram to a user (lessons 7, 10)
  describe "grams#new action" do
    
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  
    it "should successfully show the new form" do
      
# next line added 11 jul 17 for installing factory girl (lesson 11)
      user = FactoryGirl.create(:user)
      
#      user = User.create(
#        email:                 'fakeuser@gmail.com',
#        password:              'secretPassword',
#        password_confirmation: 'secretPassword'
#      )
      sign_in user
      
      get :new
      expect(response).to have_http_status(:success)

    end
  end
  
# added 11 jul 17 for adding gram in db, connecting a gram to a user (lessons 7, 10)
  describe "grams#create action" do
    
    it "should require users to be logged in" do
      post :create, params: { gram: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should successfully create a new gram in our database" do
      
# next line added 11 jul 17 for installing factory girl (lesson 11)
      user = FactoryGirl.create(:user)
      
#      user = User.create(
#        email:                 'fakeuser@gmail.com',
#        password:              'secretPassword',
#        password_confirmation: 'secretPassword'
#      )
      sign_in user
      
      post :create, params: { gram: { message: 'Hello!' } }
      expect(response).to redirect_to root_path
      
      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
    end
    
    it "should properly deal with validation errors" do
      
# next line added 11 jul 17 for installing factory girl (lesson 11)
      user = FactoryGirl.create(:user)
      
#      user = User.create(
#        email:                 'fakeuser@gmail.com',
#        password:              'secretPassword',
#        password_confirmation: 'secretPassword'
#      )
      sign_in user
      
      gram_count = Gram.count
      post :create, params: { gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(gram_count).to eq Gram.count
#      expect(Gram.count).to eq 0
    end
    
  end
  
end
