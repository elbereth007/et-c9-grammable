# firehose track 5, lesson 5 - file created 10 jul 17 for writing first test

class GramsController < ApplicationController
# next line added 11 jul 17 for connecting a gram with a user (lesson 10)
  before_action :authenticate_user!, only: [:new, :create]
  
# new method added 11 jul 17 for adding grams to db (lesson 7)
  def new
    @gram = Gram.new
  end
  
# index method added 11 jul 17 for adding grams to db (lesson 7)
  def index
  end
  
# show method added 11 jul 17 for gram detail page (lesson 12)
  def show
#    @gram = Gram.find(params[:id])
    @gram = Gram.find_by_id(params[:id])
    if @gram.blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end
  
# create method added 11 jul 17 for adding grams to db, validating grams (lessons 7, 9)
  def create
    
    # next line added 11 jul 17 for connecting a gram to a user (lesson 10)
    @gram = current_user.grams.create(gram_params)
#    @gram = Gram.create(gram_params)    # save gram to db

    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
# private gram_params method added 11 jul 17 for adding grams to db (lesson 7)
  private

  def gram_params
    params.require(:gram).permit(:message)
  end
  
end
