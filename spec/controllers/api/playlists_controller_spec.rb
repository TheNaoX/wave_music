require 'spec_helper'

describe Api::PlaylistsController do

  before(:each) do 
    @attrs = { name: 'That playlist' }
    @playlist = FactoryGirl.create(:playlist) 
    @song = FactoryGirl.create(:song)
    @playlist_song = PlaylistSong.create(song_id: @song.id, playlist_id: @playlist.id)
  end

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

    it 'should contain an array of songs information' do
      get :show, id: @playlist.id
      ActiveSupport::JSON.decode(response.body)['playlist']['songs'].first['name'].should == @song.name
    end
  end

  context '#create' do
    it 'Should create a playlist with songs' do
      Playlist.destroy_all
      post :create, playlist: @attrs
      ActiveSupport::JSON.decode(response.body)['message'].should == 'Successfully created playlist...'
      Playlist.first.name.should == "That playlist"
    end
  end

  context '#add_songs' do
    it 'should add a song to the playlist' do
      post :add_songs, id: @playlist.id, songs: [@song.id]
      ActiveSupport::JSON.decode(response.body)['message'].should == 'Successfully added new songs...'
      get :show, id: @playlist.id
      ActiveSupport::JSON.decode(response.body)['playlist']['songs'].first['name'].should == @song.name
    end
  end

end
