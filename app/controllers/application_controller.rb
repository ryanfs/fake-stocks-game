class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :logged_in?, except: [:index]

  helper_method :current_user, :logged_in?

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  private

  def logged_in?
    unless !!current_user
      flash.alert = 'You need to log in to view this page.'
      render new_session_path
    end
  end

end
