class AddSoundcloudTrackUrlToEvent < ActiveRecord::Migration
  def change
    add_column :events, :soundcloud_track_url, :string
  end
end
