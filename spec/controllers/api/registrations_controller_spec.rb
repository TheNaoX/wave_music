require 'spec_helper'

describe Api::RegistrationsController do

  context '#create' do
    it 'should create user when calling create' do
      attributes = {username: 'a username', email: 'some@email.com', password: 'filtered', password_confirmation: 'filtered'}
      post :create, user: attributes
      ActiveSupport::JSON.decode(response.body)['user']['username'].should == attributes[:username]
    end

    it 'should not create user if username is not present' do
      attributes = {email: 'some@email.com', password: 'filtered', password_confirmation: 'filtered'}
      post :create, user: attributes
      ActiveSupport::JSON.decode(response.body)['status'].should == 500
    end
  end

end
