class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.belongs_to :user, null: false
      t.belongs_to :task, null: false
      t.string :status, null: false
      t.timestamps
    end
    drop_table :tasks_users
  end
end
