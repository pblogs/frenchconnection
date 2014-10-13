class RemoveArtisans < ActiveRecord::Migration
  def down
    drop_table :artisans_tasks
    drop_table :artisans
  end
end
