class RemoveShortDescriptionFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :short_description
  end
end
