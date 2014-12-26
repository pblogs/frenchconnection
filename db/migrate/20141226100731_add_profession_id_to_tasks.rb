class AddProfessionIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :profession_id, :integer
  end
end
