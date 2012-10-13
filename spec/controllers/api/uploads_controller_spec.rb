require 'spec_helper'

describe Api::UploadsController do
  context '#create' do
    it 'should upload a song' do
      post :create
    end
  end
end
