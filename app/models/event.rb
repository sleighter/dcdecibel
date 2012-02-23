class Event < ActiveRecord::Base
  has_and_belongs_to_many :bands, :join_table => :bands_events
  belongs_to :band, :foreign_key => "headline_band_id"
  belongs_to :venue
  has_many :tickets
  scope :upcoming, where("event_datetime > ?",Time.now.utc - 5.hours)
  scope :just_announced, where("created_at > ? AND event_datetime > ?",7.days.ago.to_datetime,Time.now.utc - 5.hours)
  scope :tonight, where("event_datetime > ? AND event_datetime < ?",Time.now.utc - 5.hours, Time.now.utc.end_of_day - 5.hours)
  scope :between_dates, lambda{ |begin_date,end_date| where("event_datetime >= ?",begin_date) and where("event_datetime <= ?", end_date)}

  attr_accessor :bandid, :title, :is_in_presale
end

