require 'spec_helper'

describe Song do

  before(:each) do
    @attrs = {
      name: "For whom the bell tolls", 
      artist: 'Metallica',
      file: File.open("#{Rails.root}/spec/support/assets/songs/03 For Whom the Bell Tolls.mp3")
    }
    @not_attrs = {
      name: "Not a track name", 
      artist: 'Not an artist name',
      file: File.open("#{Rails.root}/spec/support/assets/songs/03 For Whom the Bell Tolls.mp3")
    }
  end

  context '#get_track_info'do

    it 'should get the info of the track when saved' do
      song = Song.create(@attrs)
      song.album.should == "Ride the Lightning"
    end

    it 'should set the unknown attributes if song not found' do
      song = Song.create(@not_attrs)
      song.album.should == "Unknown Album"
    end

  end

end
