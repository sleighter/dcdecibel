ActiveAdmin.register Event do
  scope :upcoming

  index do
    column :name, :sortable => :name
    column :venue
    column :event_datetime
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
        f.input :event_datetime
	      f.input :tickets_url
	      f.input :price_min
	      f.input :price_max
	      f.input :presale_start_datetime
	      f.input :presale_end_datetime
	      f.input :presale_url
	      f.input :headline_band
        f.input :bands
      end
      f.buttons
  end
# form :partial => "admin/events/form"
end

