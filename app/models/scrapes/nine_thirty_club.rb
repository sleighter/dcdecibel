class NineThirtyClub
  def scrape(venue)
    @venue = venue
    agent = Mechanize.new

    page = agent.get(@venue.scrape_url)
    @events = Array.new
    @new_events = Array.new

    page.search(".concert_listing").each do |details|
      event = Event.new
      event.title = details.search(".event").text
      event.opening_bands = Array.new
      event.opening_bands << details.search(".supports").text.sub("w/","")
      buy_link = details.search(".buy > a").first
      if buy_link != nil
        event.tickets_url = buy_link['href']
      end
      date = details.search("div.date").text
      time = /([0-9]{1,2}[:][0-9]{2}(am|pm)|[0-9](am|pm))/.match(details.search("div.doors").text)[0]
      event.event_datetime = Time.parse(date + " " + time)
      price_min = details.search(".price")
      if price_min
        event.price_min = price_min.text.sub("$","")
      end
      @events << event
    end

    @events.each do |event|
      if (@venue.events.find_all{ |e| e.event_datetime.strftime("%m/%d/%y") == event.event_datetime.strftime("%m/%d/%y")}.count == 0)
        @new_events << event
      end
    end
    
    return @new_events

  end
end