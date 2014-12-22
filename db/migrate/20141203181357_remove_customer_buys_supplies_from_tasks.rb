class RemoveCustomerBuysSuppliesFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :customer_buys_supplies
  end
end
