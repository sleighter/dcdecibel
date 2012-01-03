class Event < ActiveRecord::Base
  has_and_belongs_to_many :bands
  belongs_to :venues
  scope :upcoming, where("event_datetime > ?",Time.now)
  scope :between_dates, lambda{ |begin_date,end_date| where("event_datetime >= ?",begin_date) and where("event_datetime <= ?", end_date)}
end
