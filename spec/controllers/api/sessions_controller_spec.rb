require 'spec_helper'

describe Api::SessionsController do

  before(:each) { @user = FactoryGirl.create(:user) }
  
  context '#new' do
    it 'should create new session' do
      post :create, user_login: { email: 'user@example.com', password: 'supersecret' }
      ActiveSupport::JSON.decode(response.body)['status'].should == 200
      ActiveSupport::JSON.decode(response.body)['message'].should == 'Successfully logged in'
    end
  end

end
