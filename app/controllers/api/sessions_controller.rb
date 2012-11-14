class Api::SessionsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create, :destroy]

  respond_to :json

  def create
    begin
      resource = User.find_for_database_authentication(email: params[:user_login][:email])
      return invalid_login_attempt unless resource
      if resource.valid_password? params[:user_login][:password]
        sign_in(:user, resource)
        render json: { status: 200, message: 'Successfully logged in', user: {username: resource.username, email: resource.email, created_at: resource.created_at, updated_at: resource.updated_at, authentication_token: resource.authentication_token }}
      else
        invalid_login_attempt
      end
    rescue Exception => e
      render json: { status: 500, message: e.to_s }
    end
  end

  def destroy
    begin
      return invalid_logout_attempt unless user_signed_in?
      if sign_out(nil)
        render json: { status: 200, message: 'Successfully logged out!' }
      else
        render json: { status: 500, message: "We're sorry but something went wrong, please try again..." }
      end
    rescue Exception => e
      render json: { status: 500, message: e.to_s }
    end
  end

  private
  def invalid_login_attempt
    render json: { status: 500, message: 'Invalid login attempt', attention: "Not registered yet? <a href='http://wave_music.tangosource.com/users/sign_up'>Create new account!</a>" }
  end

  def invalid_logout_attempt
    render json: { status: 500, message: 'You need to be logged in' }
  end
end
