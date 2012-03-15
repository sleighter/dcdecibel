class AddShortDetailsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :short_details, :text
  end
end

