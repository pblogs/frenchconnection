class ChangeRowsToJsonType < ActiveRecord::Migration
  def change
    change_column :dynamic_forms, :rows, 'json USING CAST(rows AS json)'
  end
end
