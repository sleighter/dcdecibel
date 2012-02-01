class AddTicketMinPriceAndTicketMaxPriceToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :min_price, :float
    add_column :tickets, :max_price, :float
  end
end
