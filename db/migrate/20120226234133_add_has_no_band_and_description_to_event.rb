class AddHasNoBandAndDescriptionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :has_no_band, :boolean
    add_column :events, :description, :text
  end
end
