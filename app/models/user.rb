class User < ActiveRecord::Base
  validates_presence_of   :username, :email
  validates_uniqueness_of :username, :email
  before_save :ensure_authentication_token
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  has_many :api_accesses
end
