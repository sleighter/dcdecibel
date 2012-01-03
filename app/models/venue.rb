class Venue < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :bands, :through => :events, :uniq => true
end
