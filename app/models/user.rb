class User < ActiveRecord::Base
  has_many :trips
  has_many :lists, :through => :trips
  has_secure_password
  validates_presence_of :username, :email
end
