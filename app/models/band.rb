class Band < ActiveRecord::Base
  has_and_belongs_to_many :events, :join_table => :bands_events, :order => "name ASC"
  has_many :venues, :through => :events, :order => "name ASC"
  default_scope :order => "name ASC"
end
