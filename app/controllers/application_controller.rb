class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :authorize_api_access!
  after_filter  :set_access_control_headers
  protect_from_forgery

  private

  def authorize_api_access!
    puts 'Authorize only if the request comes from remote host'
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

end
