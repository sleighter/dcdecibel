class AddAnnouncedDatetimeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :announced_datetime, :timestamp
  end
end

