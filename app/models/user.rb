class User < ActiveRecord::Base
  has_many :destinations
  has_many :lists, :through => :destinations
  has_secure_password
  validates_presence_of :username, :email
  validates :password, length: { minimum: 8,
    too_short: "Must be a minimum of %(count) characters." }
end
