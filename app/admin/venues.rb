ActiveAdmin.register Venue do
  index do
    column :name
    column "Homepage", :homepage_url do |venue| 
      (venue.homepage_url != nil and venue.homepage_url != "") ? link_to("Homepage", venue.homepage_url) : ""
    end
    column "Scrape Link", :scrape_url do |venue|
      (venue.scrape_url != nil and venue.scrape_class != nil and venue.scrape_url != "" and venue.scrape_class != "") ? link_to("Scrape It!", "/scrapes/" + venue.id.to_s) : ""
    end
    column "Phone", :phone
    column "Editor\'s Choice?", :is_editors_choice do |band|
      band.is_editors_choice ? raw('&#10003;') : ''
    end
    column :default_time
    default_actions
  end
end
