class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :event_id
      t.string :seller_url
      t.float :price
      t.integer :quantity
      t.string :description

      t.timestamps
    end
  end
end
