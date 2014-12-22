class AddInventoriesTaskJoinTable < ActiveRecord::Migration
  def change
    create_table :inventories_tasks do |t|
      t.integer :inventory_id
      t.integer :task_id
    end
  end
end
