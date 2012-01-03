class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.string :last_fm_id
      t.string :wikipedia_id
      t.string :homepage_url
      t.text :bio
      t.boolean :is_editors_choice
      t.text :editors_choice_note

      t.timestamps
    end
  end
end
