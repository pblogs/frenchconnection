class AddNotEditedByAdminToHoursSpents < ActiveRecord::Migration
  def change
    add_column :hours_spents, :edited_by_admin, :boolean, default: false
  end
end
