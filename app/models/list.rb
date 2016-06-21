class List < ActiveRecord::Base
  belongs_to :trip
  validates_presence_of :title, :content
end
