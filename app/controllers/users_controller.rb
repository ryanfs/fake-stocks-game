class UsersController < ApplicationController
  skip_before_action :logged_in?
  require 'pry'

  def leaderboard
    @leaderboard_users = User.leaderboard
  end

  def new
    @user = User.new
    render new_user_path
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:user][:password_digest]

    if @user.save
      session[:user_id] = @user.id
      redirect_to markets_path
    else
      render new_user_path
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:email, :username)
  end

end
