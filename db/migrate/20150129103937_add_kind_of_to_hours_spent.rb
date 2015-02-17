class AddKindOfToHoursSpent < ActiveRecord::Migration
  def change
    add_column :hours_spents, :kind_of, :string
  end
end
