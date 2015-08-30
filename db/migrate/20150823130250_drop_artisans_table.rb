class DropArtisansTable < ActiveRecord::Migration

  def up
    drop_table :artisans
  end

  def down
    create_table :artisans
  end
end
