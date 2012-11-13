class DevelopersController < ApplicationController
  skip_before_filter :authorize_api_access!

  def index
    @applications = current_user.api_accesses
  end

  def new
    @api_access = ApiAccess.new
  end

  def create
    @api_access = ApiAccess.new(params[:api_access])
    if current_user.api_accesses << @api_access
      redirect_to developers_path
    else
      flash[:alert]='Could not register your application, verify that the name field'
    end
  end

end
