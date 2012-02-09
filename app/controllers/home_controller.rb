class HomeController < ApplicationController
  def index
    @filter = params["filter"]
    if(@filter == "upcoming")
      @events = Event.upcoming
    elsif(@filter == "justannounced")
      @events = Event.just_announced
    else
      @events = Event.upcoming
    end
    @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
  end
end

