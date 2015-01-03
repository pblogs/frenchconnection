class RemoveWorkCategories < ActiveRecord::Migration
  def change
    drop_table :work_categories
  end
end
