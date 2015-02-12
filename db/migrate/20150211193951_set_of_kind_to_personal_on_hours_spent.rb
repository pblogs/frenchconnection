class SetOfKindToPersonalOnHoursSpent < ActiveRecord::Migration
  def change
    change_column :hours_spents, :of_kind, :string, default: :personal
    HoursSpent.where(of_kind: nil).all.each do |h| 
      h.update_attribute(:of_kind, :personal)
    end
  end
end
