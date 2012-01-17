ActiveAdmin.register Event do
  scope :upcoming
  
  index do
    column :name
    column :venue
    column 'Event Date', :event_datetime
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
        f.input :event_datetime, :as => :datepicker
        f.input :bands, :as => :check_boxes
      end
      f.buttons
  end
end
