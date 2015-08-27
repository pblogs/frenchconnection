class AddCustomIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :custom_id, :string
  end
end
