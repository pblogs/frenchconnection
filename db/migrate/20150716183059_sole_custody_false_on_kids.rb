class SoleCustodyFalseOnKids < ActiveRecord::Migration
  def change
    change_column :kids, :sole_custody, :boolean, default: false
  end
end
