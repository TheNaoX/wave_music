class Api::PlaylistsController < ApplicationController
  respond_to :json

  def index
    @playlists = Playlist.all
    unless @playlists.empty?
      render_for_api :as_playlist, json: @playlists
    else
      render json: { status: 404 , message: "User does not have any playlist..." }
    end
  end

  def show
    begin
      @playlist = Playlist.find params[:id]
      render_for_api :as_playlist, json: @playlist
    rescue
      render json: { status: 404 , message: "This playlist doesn't exists" }
    end
  end

end
