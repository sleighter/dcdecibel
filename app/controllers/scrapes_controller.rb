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
      event = Event.new
      event.title = details.search(".headline a").text
      event.event_datetime = Time.parse(details.search(".date").text)
      event.opening_bands = Array.new
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
  end
end
