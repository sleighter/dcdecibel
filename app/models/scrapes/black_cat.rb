class BlackCat

  def scrape(venue)
    @venue = venue
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new


    Time.zone = ActiveSupport::TimeZone.new("America/New_York")
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
        event.price_max = price[1].sub("$","")
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
    
    return @events
  end
end