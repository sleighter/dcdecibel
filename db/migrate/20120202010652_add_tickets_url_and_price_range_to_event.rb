class AddTicketsUrlAndPriceRangeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :tickets_url, :string
    add_column :events, :price_min, :float
    add_column :events, :price_max, :float
  end
end
