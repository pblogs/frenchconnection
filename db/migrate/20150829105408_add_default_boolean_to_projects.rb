class AddDefaultBooleanToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :default, :boolean, default: false
  end

  def down
    remove_column :projects, :default
  end
end
