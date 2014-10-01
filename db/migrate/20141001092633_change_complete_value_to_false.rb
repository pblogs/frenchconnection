class ChangeCompleteValueToFalse < ActiveRecord::Migration
  def up
    Project.where(:complete => nil).all.each { |p| p.update_attribute(:complete, false) }
    change_column :projects, :complete, :boolean, :default => false 
  end
end
