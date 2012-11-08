class ApiAccess < ActiveRecord::Base
  belongs_to :user
  before_create :generate_api_access_token
  attr_accessible :application_name

  private
  def generate_api_access_token
    begin
    self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
