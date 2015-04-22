class RenameFormInfoToRowsOnDynamicForms < ActiveRecord::Migration
  def change
    rename_column :dynamic_forms, :form_info, :rows
  end
end
