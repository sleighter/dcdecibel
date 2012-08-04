ActiveAdmin.register Event do
  scope :upcoming, :default => true
  scope :incomplete_ticket_info, label: "Incomplete Ticket Info"

  index do
    column :name, :sortable => :name
    column :venue
    column :event_datetime
    column :band
    column :bands do |event|
      event.bands.take(3).each do |band|
        span do
          band.name + ", "
        end
      end
    end
    default_actions
  end

  form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :venue
        f.input :event_datetime, :label => "Event Date"
        f.input :announced_datetime, :label => "Date Announced"
	      f.input :band, :label => "Headline Band"
        f.input :bands, :label => "Opening Bands"
        f.input :opening_bands, :label => "Other Opening Bands"
        f.input :has_no_band, :label => "No Band"
        f.input :is_jazz, :label => "Jazz Event"
        f.input :is_classical, :label => "Classical Event"
        f.input :is_world, :label => "World Music Event"
      end
      f.inputs "Display Details" do
        f.input :default_open, :label => "Open Details By Default"
        f.input :short_details, :label => "Event Details To Always Show"
        f.input :description, :label => "Description for No-Band Events"
        f.input :event_photo_url, :label => "Photo URL for No-Band Events"
      end
      f.inputs "Tickets" do
        f.input :incomplete_ticket_info, label: "Enter Ticket Info Later"
        f.input :is_free, :label => "Free Event"
	      f.input :price_min, :label => "Min Ticket Price"
	      f.input :price_max, :label => "Max Ticket Price"
        f.input :tickets_sold_at_door, :label => "Tickets Sold Only At Venue"
	      f.input :tickets_url, :label => "Offical Ticket URL"
      end
      f.inputs "Presale" do
	      f.input :presale_start_datetime, :label => "Presale Start Date"
	      f.input :presale_end_datetime, :label => "Presale End Date"
	      f.input :presale_url, :label => "Presale URL"
      end
      f.buttons
  end
# form :partial => "admin/events/form"
end

