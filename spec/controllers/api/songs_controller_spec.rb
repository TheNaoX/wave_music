require 'spec_helper'

describe Api::SongsController do

  before(:each) do 
    @user = FactoryGirl.create(:user)
    @song = FactoryGirl.create(:song)
  end

  context '#index' do

    it 'should get the list of songs as JSON' do
      get :index
    end

  end
end
