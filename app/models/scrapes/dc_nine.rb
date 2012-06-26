class DCNine
  def scrape(venue)
    @venue = venue
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new


    Time.zone = ActiveSupport::TimeZone.new("America/New_York")
    page.search("h2").each do |details|
      omit = false
      
      event = Event.new
      event.name = /[\w][a-z|A-Z|\s]+/.match(details.text)[0]
      event.opening_bands = /[a-z|A-Z|\s]+/.match(details.next.next.text)[0]

      date_time_price = details.next.next.next.next.text

      begin
        date = /[a-z|A-Z]{3}\s[a-z|A-Z]{3}\s[0-9]{1,2}/.match(date_time_price)[0]
        time = /[0-9]{1,2}[:][0-9]{2}(am|pm|AM|PM)/.match(date_time_price)[0]
        event.event_datetime = Time.parse(date + " " + time)
      rescue
        omit = true
        event.event_datetime = Time.new
      end
      price = /[$][0-9]{1,3}/.match(date_time_price)
      begin  
        event.price_min = price[0].sub("$","")
        event.price_max = price[1].sub("$","")
      rescue
        if event.price_min == nil
          omit = true
        end
      end
      begin
        event.tickets_url = details.next.next.next.next.search('a')[0]['href']
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