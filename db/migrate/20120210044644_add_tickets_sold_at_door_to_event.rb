class AddTicketsSoldAtDoorToEvent < ActiveRecord::Migration
  def change
    add_column :events, :tickets_sold_at_door, :boolean
  end
end
