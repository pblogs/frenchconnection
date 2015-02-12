class AddApprovedToHoursSpents < ActiveRecord::Migration
  def change
    add_column :hours_spents, :approved, :boolean, default: false
  end
end
