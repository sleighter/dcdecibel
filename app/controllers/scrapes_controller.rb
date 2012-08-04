class ScrapesController < ApplicationController
  # GET /scrapes
  # GET /scrapes.json
  def index
    @scrapes = Scrape.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scrapes }
    end
  end

  # GET /scrapes/1
  # GET /scrapes/1.json
  def show
    @venue = Venue.find(params[:id])
#    url = @venue.schedule_url
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new
    page.search(".show-details").each do |details|
      price_and_time = details.search(".show-text").text
      event = Event.new
      event.title = details.search(".headline a").text
      begin
        time = /[0-9]{1,2}[:][0-9]{2}/.match(price_and_time)[0]
        event.event_datetime = Time.parse(details.search(".date").text + " " + time + "PM")
      rescue
      end
      event.opening_bands = Array.new
      price = /[$][0-9]{1,3}/.match(price_and_time)
      begin  
        event.price_min = price[0].sub("$","")
        event.price_max = price[1].sub("$")
      rescue
      end
      details.search(".support").each do |support|
        event.opening_bands.push(support.text)
      end
      begin
        event.tickets_url = details.search('a').last['href']
      rescue
        event.tickets_url = ""
      end
      @events.push(event)
    end
    
    @events.each do |event|
      if (@venue.events.find_all{ |e| e.event_datetime.strftime("%m/%d/%y") == event.event_datetime.strftime("%m/%d/%y")}.count == 0)
   
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
      format.json { render json: @scrape }
    end
  end

  # GET /scrapes/new
  # GET /scrapes/new.json
  def new
    @scrape = Scrape.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scrape }
    end
  end

  # GET /scrapes/1/edit
  def edit
    @scrape = Scrape.find(params[:id])
  end

  # POST /scrapes
  # POST /scrapes.json
  def create
    @scrape = Scrape.new(params[:scrape])

    respond_to do |format|
      if @scrape.save
        format.html { redirect_to @scrape, notice: 'Scrape was successfully created.' }
        format.json { render json: @scrape, status: :created, location: @scrape }
      else
        format.html { render action: "new" }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scrapes/1
  # PUT /scrapes/1.json
  def update
    @scrape = Scrape.find(params[:id])

    respond_to do |format|
      if @scrape.update_attributes(params[:scrape])
        format.html { redirect_to @scrape, notice: 'Scrape was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrapes/1
  # DELETE /scrapes/1.json
  def destroy
    @scrape = Scrape.find(params[:id])
    @scrape.destroy

    respond_to do |format|
      format.html { redirect_to scrapes_url }
      format.json { head :ok }
    end
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
