class AddRelativesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :relatives, :text
  end
end
