class Api::SessionsController < ApplicationController
  skip_before_filter :authenticate_user!
  def create
    begin
      resource = User.find_for_database_authentication(email: params[:user_login][:email])
      return invalid_login_attempt unless resource
      if resource.valid_password? params[:user_login][:password]
        sign_in(:user, resource)
        render json: { status: 200, message: 'Successfully logged in', user: resource }
      else
        invalid_login_attempt
      end
    rescue Exception => e
      render json: { status: 500, message: e.to_s }
    end
  end

  def destroy
  end

  private
  def invalid_login_attempt
    render json: { status: 500, message: 'Invalid login attempt', attention: "Not registered yet? <a href='http://wave_music.tangosource.com/users/sign_up'>Create new account!</a>" }
  end
end
