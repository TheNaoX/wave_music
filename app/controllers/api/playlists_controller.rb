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

  def create
    @playlist = Playlist.new(params[:playlist])

    if @playlist.save
      render json: { status: 200, message: 'Successfully created playlist...'}
    else
      something_went_wrong
    end
  end

  private

  def something_went_wrong
    render json: { status: 400, message: "We're sorry but something went wrong" }
  end

end
