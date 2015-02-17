class AddBillableIdToHoursSpents < ActiveRecord::Migration
  def change
    add_column :hours_spents, :billable_id, :integer
  end
end
