class AddTicketMinPriceAndTicketMaxPriceToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :ticket_min_price, :float
    add_column :venues, :ticket_max_price, :float
  end
end
