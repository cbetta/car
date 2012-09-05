class LoginController < ApplicationController
  before_filter :require_logout, except: :destroy
  
  def index
  end
  
  def callback
    user = User.from request.env['omniauth.auth']
    login user 
  end
  
  def destroy
    logout current_user
  end
end
