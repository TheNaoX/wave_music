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
end
