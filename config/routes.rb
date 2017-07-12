# firehose track 5, lesson 5 - file created 10 jul 17 for writing first test

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "grams#index"

# next line added 11 jul 17 for adding grams in db (lesson 7)
  resources :grams, only: [:new, :create]
  
end
