class AddStatusToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :draft, :boolean, default: true
  end
end
