class AddSkillsIdsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :skills_ids, :integer
  end
end
