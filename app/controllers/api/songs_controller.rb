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

  def show
    begin
      @song = Song.find params[:id]
      render_for_api :music, json: @song
    rescue
      render json: { status: 404, message: 'Song not found...' }
    end
  end

end
