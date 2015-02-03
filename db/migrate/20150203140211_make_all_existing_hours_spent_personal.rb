class MakeAllExistingHoursSpentPersonal < ActiveRecord::Migration

  def change
    HoursSpent.where(of_kind: nil).all.each do |personal| 
      personal.update_attribute(:of_kind, 'personal') 
    end
  end

end
