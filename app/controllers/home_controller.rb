class HomeController < ApplicationController
  def index      
    @events = Event.upcoming
    @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
  end

end
