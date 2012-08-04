class MerriweatherPostPavillion
  def scrape(venue)
    @venue = venue
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new


    Time.zone = ActiveSupport::TimeZone.new("America/New_York")
    page.search(".concert_listing").each do |details|
      omit = false

      price = details.search(".price").text
      date = details.search("date").text
      time = details.search("div.doors").text
      
      event = Event.new
      event.name = details.search("h2.event").text
      event.opening_bands = details.search("div.supports")[0].text
      begin
        time = /[0-9]{1,2}(am|pm|AM|PM)/.match(time)[0]
        event.event_datetime = Time.parse(date + " " + time)
      rescue
        omit = true
        event.event_datetime = Time.new
      end
      price = /[$][0-9]{1,3}/.match(price)
      begin  
        event.price_min = price[0].sub("$","")
        event.price_max = price[1].sub("$","")
      rescue
        if event.price_min == nil
          omit = true
        end
      end
      begin
        event.tickets_url = details.search('.buy>a')[0].parent['href']
      rescue
        event.tickets_url = ""
      end
      if !omit
        @events.push(event)
      end
    end
    
    return @events
  end
end