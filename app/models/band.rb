class Band < ActiveRecord::Base
  has_and_belongs_to_many :events, :join_table => :bands_events
  has_many :venues, :through => :events
end
