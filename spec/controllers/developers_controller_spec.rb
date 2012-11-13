require 'spec_helper'

describe DevelopersController do
  before(:each) {@user = FactoryGirl.create(:user)}
  context '#index' do
    it 'should display a list of registered aplications that have access to the API' do
      sign_in(@user)
      get :index
    end
  end
end
