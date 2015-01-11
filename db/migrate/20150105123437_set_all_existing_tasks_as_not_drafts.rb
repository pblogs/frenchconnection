class SetAllExistingTasksAsNotDrafts < ActiveRecord::Migration
  def change
    Task.all.each { |d| d.update_attribute(:draft, false) }
  end
end
