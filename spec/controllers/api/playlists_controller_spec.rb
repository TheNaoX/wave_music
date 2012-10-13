require 'spec_helper'

describe Api::PlaylistsController do

  before(:each) { @playlist = FactoryGirl.create(:playlist) }

  context '#index' do

    it 'Should get the index of playlists as JSON' do
      get :index
      ActiveSupport::JSON.decode(response.body)['playlists'].first['name'].should == @playlist.name
    end

    it 'Should display an error message when the playlist is empty' do
      Playlist.destroy_all
      get :index
      ActiveSupport::JSON.decode(response.body)['status'].should == 404
      ActiveSupport::JSON.decode(response.body)['message'].should == 'User does not have any playlist...'
    end

  end

  context '#show' do
    it 'should get a playlist' do
      get :show, id: @playlist.id
      response.status.should be(200)
    end

    pending 'Add more tests tomorrow here for test playlists have songs and stuff'
  end

end
