# firehost track 5, lesson 5 - file created 10 jul 17 for writing first test

require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end

  end
  
end
