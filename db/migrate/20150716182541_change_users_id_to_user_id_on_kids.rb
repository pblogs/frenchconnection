class ChangeUsersIdToUserIdOnKids < ActiveRecord::Migration
  def change
    rename_column :kids, :users_id, :user_id
  end
end
