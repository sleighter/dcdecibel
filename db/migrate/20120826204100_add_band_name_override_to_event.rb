class AddBandNameOverrideToEvent < ActiveRecord::Migration
  def change
    add_column :events, :band_name_override, :string
  end
end
