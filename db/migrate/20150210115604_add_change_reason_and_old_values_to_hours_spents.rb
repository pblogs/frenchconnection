class AddChangeReasonAndOldValuesToHoursSpents < ActiveRecord::Migration
  def change
    add_column :hours_spents, :change_reason, :text
    add_column :hours_spents, :old_values, :text
  end
end
