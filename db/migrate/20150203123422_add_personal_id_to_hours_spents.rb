class AddPersonalIdToHoursSpents < ActiveRecord::Migration
  def change
    add_column :hours_spents, :personal_id, :integer
  end
end
