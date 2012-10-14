class Api::UploadsController < ApplicationController

  def create
    unless params[:file].nil? or params[:name].nil?

      unless params[:file].class == String
        @song = Song.new(name: params[:name], artist: params[:artist], file: params[:file])
      else
        file = File.open(params[:file]) 
        @song = Song.new(name: params[:name], artist: params[:artist], file: file)
      end
      
      if @song.save
        render json: { status: :ok, message: "Successfully uploaded the song...", song: @song.id }
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
