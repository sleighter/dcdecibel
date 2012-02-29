ActiveAdmin.register Event do
  scope :upcoming, :default => true

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
        f.input :description, :label => "Description for No-Band Events"
	      f.input :price_min, :label => "Min Ticket Price"
	      f.input :price_max, :label => "Max Ticket Price"
        f.input :tickets_sold_at_door, :label => "Tickets Sold Only At Venue"
	      f.input :tickets_url, :label => "Offical Ticket URL"
	      f.input :presale_start_datetime, :label => "Presale Start Date"
	      f.input :presale_end_datetime, :label => "Presale End Date"
	      f.input :presale_url, :label => "Presale URL"
      end
      f.buttons
  end
# form :partial => "admin/events/form"
end

