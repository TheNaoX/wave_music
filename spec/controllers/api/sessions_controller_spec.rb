require 'spec_helper'

describe Api::SessionsController do
  
  context '#new' do
    it 'should create new session' do
      post :new
      ActiveSupport::JSON.decode(response.body)['status'].should == 200
      ActiveSupport::JSON.decode(response.body)['message'].should == 'Successfully logged in'
    end
  end

end
