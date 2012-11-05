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

  def stream
    begin
      @song = Song.find params[:id]
      send_file "#{Rails.root}/public#{@song.file.url}", type: MIME::Types.type_for(@song.file.url)
    rescue
      render json: { status: 404, message: 'Song not found...' }
    end
  end

  def search
    if @songs = Song.search(params[:name])
      render_for_api :music, json: @songs
    else
      render json: { status: 404 , message: "No results" }
    end
  end

end
