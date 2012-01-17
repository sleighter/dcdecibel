class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :venues
  has_many :events, :through => :venues
  default_scope :order => "name ASC"
end
