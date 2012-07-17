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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end
end

