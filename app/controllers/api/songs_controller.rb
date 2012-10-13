class Api::SongsController < ApplicationController

  def index
    @songs = Song.all
    respond_to do |format|
      format.json { render_for_api :music, json: @songs }
    end
  end

end
