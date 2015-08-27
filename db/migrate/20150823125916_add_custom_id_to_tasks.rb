class AddCustomIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :custom_id, :string
    change_column :tasks, :id, :integer, default: false
  end
end
