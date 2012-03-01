class HomeController < ApplicationController
  def index
    if (params[:q])
      @query = params[:q]
      @search = Event.upcoming(true).search(:name_contains => @query)
      @events = @search.all
      @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
      @show_search = true
    else
      @filter = params["filter"]
      if(@filter == "all")
        @events = Event.upcoming(:order => "event_datetime ASC")
        @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
      elsif(@filter == "justannounced")
        @events = Event.just_announced(:order => "created_at DESC")
        @events.sort! { |a,b| b.created_at <=> a.created_at }
      elsif(@filter == "jazz")
        @events = Event.upcoming(:order => "event_datetime ASC").select{|e| e.band and e.band.is_jazz}
        @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
      elsif(@filter == "classical")
        @events = Event.upcoming(:order => "event_datetime ASC").select{|e| e.band and e.band.is_classical}
        @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
      elsif(@filter == "local")
        @events = Event.upcoming(:order => "event_datetime ASC").select{|e| e.band and e.band.is_local}
        @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
      else
        @events = Event.upcoming(:order => "event_datetime ASC").select{|e| (!e.band or ( !e.band.is_classical and !e.band.is_jazz ))}
        @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
      end
    end

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
      event.is_in_presale = false
      if (event.presale_start_datetime and event.presale_end_datetime)
        event.is_in_presale = (event.presale_start_datetime < Time.now and event.presale_end_datetime > Time.now)
      end
    end
  end
  def about

  end
  def contact

  end
end

