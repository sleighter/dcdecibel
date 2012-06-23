class VerizonCenter
  
  schedule_url = "http://verizoncenter.com/event-schedule/?ajaxCalendar=1&month=6&year=2012&orderby=event_start_date%2Cevent_start_time%2Cevent_name&pagination=0&full=1&em_ajax=1"
  
  def scrape(venue)
    @venue = venue
    Time.zone = ActiveSupport::TimeZone.new("America/New_York")
    agent = Mechanize.new
    @events = Array.new
    @new_events = Array.new
    month_urls = Array.new
    month_years = Array.new
    month_years << Time.new.strftime("%m/%y")
    month_years << Time.new.next_month.strftime("%m/%y")
    month_years << Time.new.next_month.next_month.strftime("%m/%y")

    month_years.each do |my|
      month_urls << "http://verizoncenter.com/event-schedule/?ajaxCalendar=1&month=#{my.split('/')[0]}&year=#{my.split('/')[1]}&orderby=event_start_date%2Cevent_start_time%2Cevent_name&pagination=0&full=1&em_ajax=1"
    end
    count = 0
    month_urls.each do |month_url|
      page = agent.get(month_url)

      page.search(".eventful").each do |details|
        event = Event.new
        event.name = details.search("a").first["title"]
        event.tickets_url = details.search(".tickets_button")[0]["href"]
        time = /([0-9]{1,2}[:][0-9]{2}\s(AM|PM))/.match(details.search("li").text)[0]
        date = month_years[count]
        event.event_datetime = Time.parse(date + " " + time)
        @events << event
      end

      count += 1
    end

    return @events

  end
end