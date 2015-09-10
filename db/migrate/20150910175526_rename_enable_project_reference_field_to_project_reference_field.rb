class RenameEnableProjectReferenceFieldToProjectReferenceField < ActiveRecord::Migration
  def change
    remove_column :settings, :enable_project_reference_field
    add_column :settings, :project_reference_field, :boolean, default: false
  end
end
