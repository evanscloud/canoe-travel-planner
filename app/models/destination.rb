class Destination < ActiveRecord::Base
  belongs_to :user
  has_many :lists
  validates_presence_of :name, :location
end
