class AddPresaleStartDatetimeAndPresaleEndDatetimeAndPresaleUrlToEvent < ActiveRecord::Migration
  def change
    add_column :events, :presale_start_datetime, :datetime
    add_column :events, :presale_end_datetime, :datetime
    add_column :events, :presale_url, :string
  end
end
