class AddFrozenByAdminToHoursSpent < ActiveRecord::Migration
  def change
    add_column :hours_spents, :frozen_by_admin, :boolean, default: false
    HoursSpent.all.each { |h| h.update_attribute(:frozen_by_admin, false) }
  end
end
