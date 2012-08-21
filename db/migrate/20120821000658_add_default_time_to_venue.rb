class AddDefaultTimeToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :default_time, :time
  end
end
