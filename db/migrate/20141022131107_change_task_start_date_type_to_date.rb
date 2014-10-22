class ChangeTaskStartDateTypeToDate < ActiveRecord::Migration
  def change
    change_column :tasks, :start_date, :date
  end
end
