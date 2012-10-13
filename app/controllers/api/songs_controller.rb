class Api::SongsController < ApplicationController
  respond_to :json

  def index
    @songs = Song.all
    unless @songs.empty?
      render_for_api :music, json: @songs
    else
      respond_with message: 'The music library is empty...'
    end
  end

end
