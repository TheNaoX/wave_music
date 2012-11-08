class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  after_filter  :set_access_control_headers
  protect_from_forgery

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def host
    return 'http://localhost:3000/' if Rails.env.development?
    return 'http://wave_music.colimacolectivo.com/' if Rails.env.staging?
  end
end
