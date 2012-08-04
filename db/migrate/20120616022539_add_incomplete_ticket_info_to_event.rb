class AddIncompleteTicketInfoToEvent < ActiveRecord::Migration
  def change
    add_column :events, :incomplete_ticket_info, :boolean
  end
end
