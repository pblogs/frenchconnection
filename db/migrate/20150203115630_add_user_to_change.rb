class AddUserToChange < ActiveRecord::Migration
  def change
    add_reference :changes, :user, index: true
  end
end
