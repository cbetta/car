class LoginController < ApplicationController
  before_filter :require_logout
  
  def index
  end
  
  def callback
    user = User.from request.env['omniauth.auth']
    login user 
  end
end
