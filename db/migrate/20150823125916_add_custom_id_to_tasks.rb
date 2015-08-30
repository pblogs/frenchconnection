class AddCustomIdToTasks < ActiveRecord::Migration

  def up
    add_column :tasks, :custom_id, :string
  end

  def down
    remove_column :tasks, :custom_id
  end

end
