# firehost track 5, lesson 5 - file created 10 jul 17 for writing first test

require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  
# added action 11 jul 17 for destroying grams (lesson 14)
  describe "grams#destroy action" do
# added 12 jul 17 for securing edit/update/destroy (lesson 15)
    it "shouldn't allow users who didn't create the gram to destroy it" do
      gram = FactoryGirl.create(:gram)
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, params: { id: gram.id }
      expect(response).to have_http_status(:forbidden)
    end
  
    it "shouldn't let unauthenticated users destroy a gram" do
      gram = FactoryGirl.create(:gram)
      delete :destroy, params: { id: gram.id }
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should allow a user to destroy grams" do
      gram = FactoryGirl.create(:gram)
# next line added 12 jul 17 so only signedin user who created gram can destroy it for securing edit/update/destroy (lesson 15)
      sign_in gram.user
      
      delete :destroy, params: { id: gram.id }
      expect(response).to redirect_to root_path
      gram = Gram.find_by_id(gram.id)
      expect(gram).to eq nil
    end

    it "should return a 404 message if we cannot find a gram with the id that is specified" do
# next 2 lines added 12 jul 17 for securing edit/update/destroy (lesson 15)
      user = FactoryGirl.create(:user)
      sign_in user
  
      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end
  
  
# added action 11 jul 17 for gram edit/update (lesson 13)
  describe "grams#update action" do
# added 2 tests 12 jul 17 for securing edit/update/destroy (lesson 15)
    it "shouldn't let users who didn't create the gram update it" do
      gram = FactoryGirl.create(:gram)
      user = FactoryGirl.create(:user)
      sign_in user
      patch :update, params: { id: gram.id, gram: { message: 'wahoo' } }
      expect(response).to have_http_status(:forbidden)
    end
  
    it "shouldn't let unauthenticated users create a gram" do
      gram = FactoryGirl.create(:gram)
      patch :update, params: { id: gram.id, gram: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should allow users to successfully update grams" do
      gram = FactoryGirl.create(:gram, message: "Initial Value")
# next line added 12 jul 17 so only signedin user who created gram can update it for securing edit/update/destroy (lesson 15)
      sign_in gram.user
      
      patch :update, params: { id: gram.id, gram: { message: 'Changed' } }
      expect(response).to redirect_to root_path
      gram.reload
      expect(gram.message).to eq "Changed"
    end

    it "should have http 404 error if the gram cannot be found" do
# next 2 lines added 12 jul 17 for securing edit/update/destroy (lesson 15)
      user = FactoryGirl.create(:user)
      sign_in user
      
      patch :update, params: { id: "YOLOSWAG", gram: { message: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      gram = FactoryGirl.create(:gram, message: "Initial Value")
# next line added 12 jul 17 for securing edit/update/destroy (lesson 15)
      sign_in gram.user
      
      patch :update, params: { id: gram.id, gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      gram.reload
      expect(gram.message).to eq "Initial Value"
    end
  end
  
  
# added action 11 jul 17 for gram edit/update (lesson 13)
  describe "grams#edit action" do
# added 12 jul 17 for securing edit/update/destroy (lesson 15)
    it "shouldn't let a user who did not create the gram edit a gram" do
      gram = FactoryGirl.create(:gram)    # create a gram
      user = FactoryGirl.create(:user)    # create new user and sign it in
      sign_in user
      get :edit, params: { id: gram.id }  # trigger edit action
      expect(response).to have_http_status(:forbidden)  # expect forbidden
    end
    
    it "shouldn't let unauthenticated users edit a gram" do
      gram = FactoryGirl.create(:gram)
      get :edit, params: { id: gram.id }
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should successfully show the edit form if the gram is found" do
      gram = FactoryGirl.create(:gram)
# next line added 12 jul 17 for securing edit/update/destroy (lesson 15)
      sign_in gram.user
      
      get :edit, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the gram is not found" do
# next 2 lines added 12 jul 17 for securing edit/update/destroy (lesson 15)
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :edit, params: { id: 'SWAG' }
      expect(response).to have_http_status(:not_found)
    end
  end
  
  
# added 11 jul 17 for gram detail page (lesson 12)
  describe "grams#show action" do
    it "should successfully show the page if the gram is found" do
      gram = FactoryGirl.create(:gram)
      get :show, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end


# added 10 jul 17 for writing first test
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
