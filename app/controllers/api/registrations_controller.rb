class Api::RegistrationsController < ApplicationController
  skip_before_filter :authenticate_user!
  respond_to :json

  def create
    begin
      return ilegal_registration if params[:user].nil?
      @user = User.new(params[:user])
      if @user.save
        render json: {status: 200, message: "Successfully registered user", user: @user}
      else
        ilegal_registration
      end
    rescue Exception => e
      render json: {status: 500, message: e.to_s}
    end
  end

  private
  def ilegal_registration
    render json: {status: 500, message: "We're sorry but something went wrong..."}
  end

end
