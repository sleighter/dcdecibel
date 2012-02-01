ActiveAdmin.register Ticket do
  index do
    column "Event Name",:sortable => :event_id do |ticket|
      Event.find(ticket.event_id).name
    end
    column "Sale Link", :seller_url do |ticket|
      link_to "Link", ticket.seller_url
    end
    column "QTY", :quantity
    column "Price", :sortable => :price do |ticket|
      span :class => "currency", do 
        number_to_currency(ticket.price)
      end
    end
    default_actions
  end
  
  form do |f|
    f.inputs "Basic Information" do
      f.input :event
      f.input :seller_url
      f.input :quantity
      f.input :min_price
      f.input :max_price
      f.input :description
    end
    f.buttons
  end

end
