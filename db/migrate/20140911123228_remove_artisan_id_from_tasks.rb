class RemoveArtisanIdFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :artisan_id
  end
end
