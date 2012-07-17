class VenuesController < ApplicationController
include ActionView::Helpers::NumberHelper

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
    @venues.each do |venue|
      venue.phone = number_to_phone(venue.phone)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue = Venue.find(params[:id])
    @venue.phone = number_to_phone(@venue.phone)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @venue }
    end
  end
end

