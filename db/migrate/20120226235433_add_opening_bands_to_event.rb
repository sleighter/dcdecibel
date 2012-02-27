class AddOpeningBandsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :opening_bands, :string
  end
end
