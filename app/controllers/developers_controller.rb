class DevelopersController < ApplicationController

  def index
    @applications = current_user.api_accesses
  end

  def new
    @api_access = ApiAccess.new
  end

  def create
    @api_access = ApiAccess.new(params[:api_access])
    if @api_access.save
      redirect_to developers_path
    else
      flash[:alert]='Could not register your application, verify that the name field'
    end
  end

end
