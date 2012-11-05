class Api::RegistrationsController < ApplicationController
  doorkeeper_for :all
end
