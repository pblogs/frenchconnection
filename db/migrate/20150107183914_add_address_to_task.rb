class AddAddressToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :address, :string
  end
end
