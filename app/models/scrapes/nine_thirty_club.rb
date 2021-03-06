class NineThirtyClub
  def scrape(venue)
    @venue = venue
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new

    Time.zone = ActiveSupport::TimeZone.new("America/New_York")
    page.search(".concert_listing").each do |details|
      omit = false
      event = Event.new
      event.name = details.search(".event").text
      event.opening_bands = details.search(".supports").text.sub("w/","")
      buy_link = details.search(".buy > a").first
      if buy_link != nil
        event.tickets_url = buy_link['href']
      end
      date = details.search("div.date").text
      time = /([0-9]{1,2}[:][0-9]{2}(am|pm)|[0-9]{1,2}(am|pm))/.match(details.search("div.doors").text)[0]
      event.event_datetime = Time.parse(date + " " + time)
      price_min = details.search(".price")
      if price_min
        event.price_min = price_min.text.sub("$","")
      end
      if event.price_min == nil
        omit = true
      end
      if !omit
        @events << event
      end
    end
    
    return @events

  end
end