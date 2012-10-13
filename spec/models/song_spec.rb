require 'spec_helper'

describe Song do
  before(:each) do
    @song = FactoryGirl.create(:song)
    @songs = Song.all
  end
  context 'JSON' do

    it 'should return collection of songs as JSON' do
      (render_for_api :music, json: @songs).first.should be_kind_of ActiveSupport::JSON
    end

  end

end
