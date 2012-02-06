class AddIsClassicalAndIsJazzToBand < ActiveRecord::Migration
  def change
    add_column :bands, :is_classical, :boolean
    add_column :bands, :is_jazz, :boolean
  end
end
