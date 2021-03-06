class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :homepage_url
      t.string :wikipedia_id
      t.string :address
      t.string :city_address
      t.string :state
      t.integer :zip
      t.text :description
      t.boolean :is_editors_choice
      t.text :editors_choice_note
      t.string :phone
      t.integer :city_id

      t.timestamps
    end
  end
end
