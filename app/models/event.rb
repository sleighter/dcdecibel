class Event < ActiveRecord::Base
  has_and_belongs_to_many :bands, :join_table => :bands_events
  belongs_to :venue
  has_many :tickets
  scope :upcoming, where("event_datetime > ?",Time.now)
  scope :just_announced, where("created_at > ?",Time.now - 7.days)
  scope :tonight, where("event_datetime > ?",Time.now)
  scope :between_dates, lambda{ |begin_date,end_date| where("event_datetime >= ?",begin_date) and where("event_datetime <= ?", end_date)}

end
