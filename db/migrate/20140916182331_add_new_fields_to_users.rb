class AddNewFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_address, :string
    add_column :users, :home_area_code, :string
    add_column :users, :home_area, :string
  end
end
