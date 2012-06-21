class AddScrapeUrlAndScrapeClassToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :scrape_url, :string
    add_column :venues, :scrape_class, :string
  end
end
