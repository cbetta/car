class LoginController < ApplicationController
  before_filter :require_logout, except: [:destroy, :no_access]
  
  def index
  end
  
  def callback
    user = User.from request.env['omniauth.auth']
    login user 
  end
  
  def destroy
    logout current_user
  end
  
  def no_access
  end
end
