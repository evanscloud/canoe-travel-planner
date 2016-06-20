class List < ActiveRecord::Base
  belongs_to :destination
  validates_presence_of :title
end
