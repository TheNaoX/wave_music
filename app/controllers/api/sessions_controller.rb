class Api::SessionsController < ApplicationController
  def create
    begin
      binding.pry
      @user = User.find_for_database_authentication(params[:user_login][:email])
      return invalid_login_attempt unless resource
      if resource.valid_password? params[:user_login][:password]
        sign_in('user', resource)
        render json: { status: 200, message: 'Successfully logged in' }
      else
        invalid_login_attempt
      end
    rescue Exception => e
      render json: { status: 500, message: e.to_s }
    end
  end

  private
  def invalid_login_attempt
    render json: { status: 500, message: 'Invalid login attempt' }
  end
end
