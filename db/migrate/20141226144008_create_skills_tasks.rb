class CreateSkillsTasks < ActiveRecord::Migration
  def change
    create_table :skills_tasks do |t|
      t.integer :skill_id
      t.integer :task_id
    end
  end
end
