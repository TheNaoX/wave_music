require 'spec_helper'

describe Api::RegistrationsController do
  context '#create' do
    it 'should create user when is POSTED' do
      post :create
    end
  end
end
