class HomeController < ApplicationController
  def index
    if (params[:q])
      @query = params[:q]
      @events = Event.upcoming(true)
      @search_by_band = @events.search(:name_contains => @query)
      @search_by_openers = @events.search(:opening_bands_contains => @query)
      @search_by_venue = @events.search(:venue_name_contains => @query)
      @events = @search_by_band.all + @search_by_venue.all + @search_by_openers.all
      @show_search = true
    else
      @filter = params["filter"]
      if(@filter == "all")
        @events = Event.upcoming(true)
      elsif(@filter == "justannounced")
        @events = Event.just_announced(true)
      elsif(@filter == "jazz")
        @events = Event.upcoming(true).select{|e| e.is_jazz or (e.band and e.band.is_jazz)}
      elsif(@filter == "world")
        @events = Event.upcoming(true).select{|e| e.is_world or (e.band and e.band.is_jazz)}
      elsif(@filter == "classical")
        @events = Event.upcoming(true).select{|e| e.is_classical or (e.band and e.band.is_classical)}
      elsif(@filter == "local")
        @events = Event.upcoming(true).select{|e| e.band and e.band.is_local}
      elsif(@filter == "recommended")
        @events = Event.upcoming(true).select{|e| e.band and e.band.is_editors_choice}
      elsif(@filter == "presale")
        @events = Event.upcoming(true).select{|e| e.presale_end_datetime and (e.presale_end_datetime > Time.now)}
      else
        @events = Event.upcoming(true).select{|e| ! e.is_world and !e.is_jazz and !e.is_classical and (!e.band or ( !e.band.is_classical and !e.band.is_jazz ))}
      end
    end
    @events = @events.find_all{|item| item.event_datetime > Time.now.beginning_of_day - 5.hours}
    @events.sort! { |a,b| a.event_datetime <=>  b.event_datetime }
    @events.each do |event|
      if (event.headline_band_id and event.band != nil)
        event.bandid = event.band.id
        event.title = event.name ? event.name : event.band.name
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
      if(!event.soundcloud_track_url or event.soundcloud_track_url == "")
        client_id = '3d42140e294f456608c2fb5705a0d9ea' #ENV['SOUNDCLOUD_CLIENT_ID']
        search_term = event.band_name_override ? event.band_name_override : (event.name ? event.name : event.band.name)
        search_term = search_term.gsub(/\s+/, "")
        begin
          response = JSON.parse(Net::HTTP.get_response("api.soundcloud.com","/resolve.json?url=http://soundcloud.com/" + search_term + "&client_id=" + client_id).body)
          response = JSON.parse(Net::HTTP.get_response(URI(response['location'])).body)
          response = JSON.parse(Net::HTTP.get_response(URI("http://api.soundcloud.com/users/" + response['id'].to_s + "/tracks.json?filter=streamable&order=hotness&client_id=" + client_id)).body)[0]
          event.soundcloud_track_url = response['uri']
          event.save
        rescue
          event.soundcloud_track_url = 'error'
        end
      end
    end
  end
  def about

  end
  def contact

  end
end

