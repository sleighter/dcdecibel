class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    if ((@event.opening_bands == nil or @event.opening_bands == "") and @event.bands)
      @event.opening_bands = "";
      @event.bands.each do |b|
        if (@event.band and b.name != @event.band.name)
          @event.opening_bands = @event.opening_bands + " " + b.name
        end
      end
    end
    if (@event.event_datetime.hour == 00)
      if (@event.venue.default_time != nil)
        @event.timestr = @event.venue.default_time.strftime("%l %p")
      else
        @event.timestr = ""
      end
    else
      @event.timestr = @event.event_datetime.strftime("%l %p")
    end
    puts @event.timestr
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event.to_json(:methods => [:timestr]) }
    end
  end
end

