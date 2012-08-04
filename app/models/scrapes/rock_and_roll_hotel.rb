class RockAndRollHotel
  def scrape(venue)
    @venue = venue
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new


    Time.zone = ActiveSupport::TimeZone.new("America/New_York")
    page.search(".sectiontableentry1,.sectiontableentry2").each do |details|
      omit = false
      price = details.search(".gigcal_list_cover").text
      date = /[a-z|A-Z]{3}\s[a-z|A-Z]{3}\s[0-9]{1,2}/.match(details.search(".gigcal_list_date").text)[0]
      time = details.search(".gigcal_list_details").text
      event = Event.new
      headliners = Array.new
      details.search(".band_headliner").each do |headliner|
        headliners << headliner.text
      end
      event.name = headliners.join(", ")
      
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
        event.tickets_url = details.search('.tickets')[0].parent['href']
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