class ScrapesController < ApplicationController
  # GET /scrapes/1
  # GET /scrapes/1.json
  def show
    @venue = Venue.find(params[:id])
   
    @new_events = @venue.scrape_class.constantize.new.scrape(@venue)


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scrape }
    end
  end
end
