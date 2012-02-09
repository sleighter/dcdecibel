class AddHeadlineBandIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :headline_band_id, :integer
  end
end
