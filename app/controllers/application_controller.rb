class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
# next 3 lines added 12 jul 17 for comments (lesson 18)
  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end
  
end
