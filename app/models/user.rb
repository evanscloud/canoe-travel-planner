class User < ActiveRecord::Base
  has_many :destinations
  has_many :lists, :through => :destinations
  has_secure_password
end
