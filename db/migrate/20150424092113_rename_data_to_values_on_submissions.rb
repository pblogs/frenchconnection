class RenameDataToValuesOnSubmissions < ActiveRecord::Migration
  def change
    rename_column :submissions, :data, :values
  end
end
