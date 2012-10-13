require 'spec_helper'

describe Song do
  before(:each) do
    @song = FactoryGirl.create(:song)
    @songs = Song.all
  end
  context 'JSON' do

    pending 'Test API accessible'

  end

end
