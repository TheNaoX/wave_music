class Api::UploadsController < ApplicationController
  def create
    file = File.open(params[:song][:file])
    @song = Song.new(name: params[:song][:name], file: file)
    if @song.save
      render json: { status: :ok, message: "Successfully uploaded the song..." }
    else
      render json: { status: 400, message: "We're sorry but something went wrong" }
    end
  end
end
