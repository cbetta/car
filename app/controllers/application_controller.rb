class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?, :access?
  
  def current_user
    return nil if session[:user_token].blank?
    @current_user ||= User.find_by_auth_token(session[:user_token])
    check_session_expired
    @current_user
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def access?
    current_user.has_access?
  end
  
  protected
  
  def check_session_expired
    if @current_user && @current_user.auth_token_expired?
      @current_user.clear_auth_token
      @current_user = nil 
    end
  end
  
  def require_login
    redirect_to login_path unless logged_in?
  end
  
  def require_access
    logout current_user unless access?
  end
  
  def require_logout
    redirect_to root_url if logged_in?
  end
  
  def login user
    redirect_to login_path if user.nil? 
    session[:user_token] = user.update_auth_token
    redirect_to root_url
  end
  
  def logout user
    user.clear_auth_token
    session[:user_token] = nil
    redirect_to login_path
  end
end
