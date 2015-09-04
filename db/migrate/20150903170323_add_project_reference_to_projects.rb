class AddProjectReferenceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_reference, :string
  end
end
