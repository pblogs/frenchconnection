class RemoveCustomIdFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :custom_id
  end
end
