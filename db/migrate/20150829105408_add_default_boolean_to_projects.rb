class AddDefaultBooleanToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :default, :boolean, default: false
  end
end
