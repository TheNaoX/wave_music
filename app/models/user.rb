class User < ActiveRecord::Base
  validates_presence_of   :username, :email
  validates_uniqueness_of :username, :email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  has_many :api_accesses
end
