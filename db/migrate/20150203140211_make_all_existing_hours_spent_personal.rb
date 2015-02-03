class MakeAllExistingHoursSpentPersonal < ActiveRecord::Migration

  def change
    HoursSpent.where(of_kind: nil).all.each do |personal| 
      personal.update_attribute(:of_kind, 'personal') 
      billable = personal.dup
      billable.update_attributes(personal_id: personal.id, of_kind: 'billable')
    end
  end

end
