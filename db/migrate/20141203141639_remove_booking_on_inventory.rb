class RemoveBookingOnInventory < ActiveRecord::Migration
  def change
    remove_column :inventories, :booked_from
    remove_column :inventories, :booked_to
  end
end
