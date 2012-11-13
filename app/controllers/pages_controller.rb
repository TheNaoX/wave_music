class PagesController < ApplicationController
  skip_before_filter :authorize_api_access!
  def index
  end
end
