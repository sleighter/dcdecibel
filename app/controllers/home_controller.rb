class HomeController < ApplicationController
  def index
    if (params[:q])
      @query = params[:q]
      @eventsearch = Event.search(@query)
      @events = @search.all
    else
      @filter = params["filter"]
      if(@filter == "upcoming")
        @events = Event.upcoming
      elsif(@filter == "justannounced")
        @events = Event.just_announced
      else
        @events = Event.upcoming
      end
    end
    @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }

    @events.each do |event|
      if (event.headline_band_id)
        event.bandid = event.band.id
        event.title = event.band.name
      elsif (event.bands.select{|n| n.name == event.name}.first)
        event_band = event.bands.select{ |n| n.name == event.name }.first
        event.bandid = event_band.id
        event.title = event_band.name
      elsif (event.bands.first)
        event.bandid = event.bands.first.id
        event.title = event.bands.first.name
      else
        event.bandid = ''
        event.title = event.name
      end
    end
  end
  def about

  end
  def contact

  end
end

