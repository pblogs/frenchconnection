class DropArtisansTable < ActiveRecord::Migration
  def change
    drop_table :artisans
  end
end
