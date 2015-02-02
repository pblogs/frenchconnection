class RenameHoursSpentKindOf < ActiveRecord::Migration
  def change
    rename_column :hours_spents, :kind_of, :of_kind
  end
end
