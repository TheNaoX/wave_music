require 'spec_helper'

describe DevelopersController do
  before(:each) {
    @user = FactoryGirl.create(:user)
    @user.api_accesses << FactoryGirl.build(:api_access)
    sign_in(@user)
  }

  context '#index' do
    it 'should display a list of registered aplications that have access to the API' do
      get :index
      page.has_content?'My application'
      page.has_selector?"input[type='submit']"
    end
  end

  context '#new' do
    it 'should display a form when user wants to register new application' do
      get :new
      page.has_selector?"input[type='submit']"
    end
  end

  context '#create' do
    it 'should register a new application with access token' do
      post :create, api_access: {application_name:'My application'} 
    end
  end

end
