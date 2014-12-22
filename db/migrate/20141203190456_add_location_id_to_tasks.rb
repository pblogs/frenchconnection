class AddLocationIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :location_id, :integer
  end
end
