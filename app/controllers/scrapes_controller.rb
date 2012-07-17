class ScrapesController < ApplicationController
  # GET /scrapes/1
  # GET /scrapes/1.json
  def show
    @venue = Venue.find(params[:id])
   
    @new_events = Array.new

    @events = @venue.scrape_class.constantize.new.scrape(@venue)

    @events.each do |event|
      if (@venue.events.find_all{ |e| 
              (e.event_datetime.strftime("%m/%d/%y") == event.event_datetime.strftime("%m/%d/%y")) and 
              (
                (e.name.downcase == event.name.downcase) or 
                (e.band != nil and (e.band.name.downcase == event.name.downcase))
              )
            }.count == 0)
        event.venue_id = params[:id]
        band = Band.find_by_name(event.name)
        event.band = band
        @new_events << event
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @new_events }
    end
  end

  def create
    #@events = params[:event]
#
#    #@events.each do |event|
#    #  if (event.has_key? 'selected')
#    #    event['price_min'] = event['price_min']
#    #    begin
#    #      event['event_datetime'] = Time.parse(event['event_datetime'])
    #    rescue
    #    end
    #    new_event = Event.new(event)
    #    new_event.save
    #  end
    #end
    #respond_to do |format|
    #    format.html { redirect_to @event, notice: 'Event was successfully created.' }
    #    format.json { render json: @event, status: :created, location: @event }
    #end
  end
end
