class Api::UploadsController < ApplicationController

  def create
    unless params[:song].nil?

      file = File.open(params[:song][:file])
      @song = Song.new(name: params[:song][:name], file: file)
      
      if @song.save
        render json: { status: :ok, message: "Successfully uploaded the song..." }
      else
        something_went_wrong
      end

    else
      something_went_wrong 
    end
  end

  private

  def something_went_wrong
    render json: { status: 400, message: "We're sorry but something went wrong" }
  end

end
