class AddIsJazzAndIsClassicalToEvent < ActiveRecord::Migration
  def change
    add_column :events, :is_jazz, :boolean
    add_column :events, :is_classical, :boolean
  end
end
