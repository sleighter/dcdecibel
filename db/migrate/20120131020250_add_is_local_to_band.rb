class AddIsLocalToBand < ActiveRecord::Migration
  def change
    add_column :bands, :is_local, :boolean
  end
end
