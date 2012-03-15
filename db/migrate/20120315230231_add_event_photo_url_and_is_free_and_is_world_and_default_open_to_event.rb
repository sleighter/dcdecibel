class AddEventPhotoUrlAndIsFreeAndIsWorldAndDefaultOpenToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_photo_url, :string
    add_column :events, :is_free, :boolean
    add_column :events, :is_world, :boolean
    add_column :events, :default_open, :boolean
  end
end
