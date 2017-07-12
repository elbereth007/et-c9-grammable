# firehost track 5, lesson 5 - file created 10 jul 17 for writing first test

require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

# added 11 jul 17 for adding gram in db (lesson 7)
  describe "grams#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)

    end
  end
  
# added 11 jul 17 for adding gram in db (lesson 7)
  describe "grams#create action" do
    it "should successfully create a new gram in our database" do
      post :create, params: { gram: { message: 'Hello!' } }
      expect(response).to redirect_to root_path
    end
  end
  
end
