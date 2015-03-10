class RemoveFrozenByAdminFromHoursSpents < ActiveRecord::Migration
  def change
    remove_column :hours_spents, :frozen_by_admin
  end
end
