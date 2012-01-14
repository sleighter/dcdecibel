class Ticket < ActiveRecord::Base
  belongs_to :event
  has_one :venue, :through => :event
end
