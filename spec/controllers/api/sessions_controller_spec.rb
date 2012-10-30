require 'spec_helper'

describe Api::SessionsController do
  
  context '#new' do
    it 'should create new session' do
      get :new
    end
  end

end
