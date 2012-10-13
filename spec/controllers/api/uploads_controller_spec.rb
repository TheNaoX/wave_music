require 'spec_helper'

describe Api::UploadsController do
  before(:each) do
    @attrs = {
      name: "For whom the bell tolls", 
      file: "/Users/thenaox/projects/r12-team-455/spec/support/assets/songs/03 For Whom the Bell Tolls.mp3"
    }
    @new_attrs = {
      name: "For whom the bell tolls", 
      file: File.open(File.join(Rails.root, 'spec', 'support', 'assets', 'songs', '03 For Whom the Bell Tolls.mp3'))
    }
  end

  context '#create' do
    it 'should upload a song' do
      post :create, song: @attrs
      ActiveSupport::JSON.decode(response.body)['message'].should == 'Successfully uploaded the song...'
    end

    it 'should save correctly the song' do
      post :create, song: @attrs
      Song.first.file.file.filename.should == "03_For_Whom_the_Bell_Tolls.mp3"
    end

    it 'should not create song if does not have valid attributes' do
      post :create, song: nil
      ActiveSupport::JSON.decode(response.body)['status'].should == 400
    end

    it 'should upload a song if a file is sent' do
      post :create, song: @new_attrs
      binding.pry
    end

  end

end
