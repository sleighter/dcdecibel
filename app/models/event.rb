class Event < ActiveRecord::Base
  has_and_belongs_to_many :bands, :join_table => :bands_events
  belongs_to :band, :foreign_key => "headline_band_id"
  belongs_to :venue
  has_many :tickets
  scope :upcoming, where("event_datetime > ?",Time.now)
  scope :just_announced, where("created_at > ? AND event_datetime > ?",7.days.ago.to_datetime,Time.now)
  scope :tonight, where("event_datetime > ?",Time.now)
  scope :between_dates, lambda{ |begin_date,end_date| where("event_datetime >= ?",begin_date) and where("event_datetime <= ?", end_date)}

end

