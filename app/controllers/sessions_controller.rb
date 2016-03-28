class SessionsController < ApplicationController
  skip_before_action :logged_in?

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password_digest])
      session[:user_id] = @user.id
      redirect_to markets_path
    else
      redirect_to login_path, :flash => { :error => "The email or password you entered is incorrect." }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
