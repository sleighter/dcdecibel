class AddScrapeUrlToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :scrape_url, :string
  end
end
