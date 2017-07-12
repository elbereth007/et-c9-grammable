# firehose track 5, lesson 5 - file created 10 jul 17 for writing first test

class GramsController < ApplicationController
  
# new method added 11 jul 17 for adding grams to db (lesson 7)
  def new
    @gram = Gram.new
  end
  
# index method added 11 jul 17 for adding grams to db (lesson 7)
  def index
  end
  
# create method added 11 jul 17 for adding grams to db (lesson 7)
  def create
    @gram = Gram.create(gram_params)    # save gram to db
    redirect_to root_path
  end
  
# private gram_params method added 11 jul 17 for adding grams to db (lesson 7)
  private

  def gram_params
    params.require(:gram).permit(:message)
  end
  
end
