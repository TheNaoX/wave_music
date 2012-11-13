class ApiAccess < ActiveRecord::Base
  belongs_to :user
  before_create :generate_api_access_token
  validates_presence_of :application_name
  attr_accessible :application_name
  validates_uniqueness_of :access_token

  private
  def generate_api_access_token
    begin
    self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
