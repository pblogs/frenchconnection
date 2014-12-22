class AddWorkCategoryIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :work_category_id, :integer
  end
end
