class City < ActiveRecord::Base
  has_many :neighborhoods, :order => "name ASC"
  has_many :venues, :order => "name ASC"
  has_many :events, :through => :venues
  default_scope :order => "name ASC"
end
