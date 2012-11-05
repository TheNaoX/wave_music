require 'spec_helper'

describe Api::SessionsController do

  before(:each) { @user = FactoryGirl.create(:user) }
  
  context '#new' do
    it 'should create new session' do
      post :create, user_login: { email: 'user@example.com', password: 'supersecret' }
      ActiveSupport::JSON.decode(response.body)['message'].should == 'Successfully logged in'
      ActiveSupport::JSON.decode(response.body)['status'].should == 200
    end

    it 'Should reject session if user login is empty' do
      post :create, user_login: 'Empty user login'
      ActiveSupport::JSON.decode(response.body)['status'].should == 500
    end

    it 'Should reject session if user login is not valid' do
      post :create, user_login: {email: 'not@valid.email', password: 'superwrong'}
      ActiveSupport::JSON.decode(response.body)['status'].should == 500
    end
  end

  context '#destroy' do
    it 'should destroy session when requested' do
      delete :destroy
      ActiveSupport::JSON.decode(response.body)['status'] == 200
      ActiveSupport::JSON.decode(response.body)['message'] == 'Successfully signed out!'
    end
  end

end
