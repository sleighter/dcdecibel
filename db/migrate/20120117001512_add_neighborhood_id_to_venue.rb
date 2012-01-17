class AddNeighborhoodIdToVenue < ActiveRecord::Migration
  def change
    add_column    :venues, :neighborhood_id, :integer
  end
end
