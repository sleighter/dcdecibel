class JamminJava
  def scrape(venue)
    @venue = venue
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new

    Time.zone = ActiveSupport::TimeZone.new("America/New_York")
    page.search("div.event").each do |details|
      event = Event.new
      event.name = details.search(".event-headline").text
      event.opening_bands = details.search(".supporting-act").text.sub("+","")
      buy_link = details.search(".buy-tickets-button > a").first
      if buy_link != nil
        event.tickets_url = buy_link['href']
      end
      event.event_datetime = Time.parse(details.search(".event-date").text)
      price_min = details.search(".price")
      if price_min
        event.price_min = price_min.text.sub("$","")
      end
      if (event.name)
        @events << event
      end
    end
    
    #@events.select{|e| e.tickets_url != nil}.each do |event|
    #  page = agent.get(event.tickets_url)
    #  price = page.search("div.price").text.sub("$","")
    #end

    return @events

  end
end