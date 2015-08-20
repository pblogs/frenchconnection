class AddBirthDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_date, :date
    remove_column :users, :age
  end
end
