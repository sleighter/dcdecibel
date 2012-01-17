class Venue < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :bands, :through => :events, :uniq => true
  has_many :tickets, :through => :events
  belongs_to :city
  belongs_to :neighborhood
  default_scope :order => "name ASC"
end
