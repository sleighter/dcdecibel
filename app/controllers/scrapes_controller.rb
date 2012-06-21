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
              ((e.name.downcase == event.title.downcase) or (e.band.name.downcase == event.title.downcase))
            }.count == 0)
        @new_events << event
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @new_events }
    end
  end
end
