# firehose track 5, lesson 5 - file created 10 jul 17 for writing first test

class GramsController < ApplicationController
# next line added 11 jul 17/modified 12 jul 17 for connecting a gram with a user, securing edit/update/destroy (lessons 10, 15)
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
# destroy method added 11 jul 17 for destroying grams (lesson 14)
  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
# next 3 lines added/modified 12 jul 17 for securing edit/update/destroy (lesson 15)
#    if @gram.user != current_user
#      return render plain: 'Forbidden :(', status: :forbidden
    return render_not_found(:forbidden) if @gram.user != current_user
#    end
  
    @gram.destroy
    redirect_to root_path
  end
  
# update method added 11 jul 17 for edit/update grams (lesson 13)
  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
# next 3 lines added/modified 12 jul 17 for securing edit/update/destroy (lesson 15)
#    if @gram.user != current_user
#      return render plain: 'Forbidden :(', status: :forbidden
    return render_not_found(:forbidden) if @gram.user != current_user
#    end
    
    @gram.update_attributes(gram_params)
    
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end
  
# new method added 11 jul 17 for adding grams to db (lesson 7)
  def new
    @gram = Gram.new
  end
  
# index method added 11 jul 17 for adding grams to db (lesson 7)
  def index
  end
  
# show method added 11 jul 17 for gram detail page, edit/update grams (lessons 12, 13)
  def show
#    @gram = Gram.find(params[:id])
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end
  
# edit method added 11 jul 17 for edit/update grams (lesson 13)
  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
# next 3 lines added/modified 12 jul 17 for securing edit/update/destroy (lesson 15)
#    if @gram.user != current_user
#      render plain: 'Forbidden :(', status: :forbidden
    return render_not_found(:forbidden) if @gram.user != current_user
#    end
    
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
  
# render_not_found method added 11 jul 17 for edit/update grams (lesson 13)

#  def render_not_found
#    render plain: 'Not Found :(', status: :not_found
#  end

# next 3 lines modified 12 jul 17 for securing edit/update/destroy (lesson 15)
  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end
  
end
