class RemoveStarredFromProjectsAndCustomers < ActiveRecord::Migration
  def up
    remove_column :projects, :starred
    remove_column :customers, :starred
  end

  def down
    add_column :projects, :starred, :boolean
    add_column :customers, :starred, :boolean
  end
end
