class AddTitleToDynamicForms < ActiveRecord::Migration
  def change
    add_column :dynamic_forms, :title, :string
  end
end
