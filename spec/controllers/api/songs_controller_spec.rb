require 'spec_helper'

describe Api::SongsController do

  before(:each) do 
    @user = FactoryGirl.create(:user)
    @song = FactoryGirl.create(:song)
  end

  context '#index' do

    it 'should get the list of songs as JSON' do
      get :index, format: :json
      ActiveSupport::JSON.decode(response.body)['songs'].first['name'].should == 'For whom the bell tolls'
    end

    it 'should return a message if there are not songs in the API' do
      Song.destroy_all
      get :index, format: :json
      ActiveSupport::JSON.decode(response.body)['message'].should == 'The music library is empty...'
    end

  end

   context '#show' do
     it 'should display only one song' do
       get :show, id: @song.id
       ActiveSupport::JSON.decode(response.body)['song']['name'].should == 'For whom the bell tolls'
     end
     
     it 'should get the url of the song' do
       get :show, id: @song.id
       ActiveSupport::JSON.decode(response.body)['song']['url'].should == @song.file.url
     end

     it 'should get an error if the song is not valid' do
       get :show, id: 'not valid id'
       ActiveSupport::JSON.decode(response.body)['message'].should == 'Song not found...'
     end
   end

end
