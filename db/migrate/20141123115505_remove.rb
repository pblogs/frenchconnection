class Remove < ActiveRecord::Migration
  def change
    remove_column :tasks, :task_type_id
    remove_column :tasks, :paint_id
  end
end
