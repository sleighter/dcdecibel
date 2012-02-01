class AddTicketMinPriceAndTicketMaxPriceToEvent < ActiveRecord::Migration
  def change
    add_column :events, :ticket_min_price, :float
    add_column :events, :ticket_max_price, :float
  end
end
