class CreateZippedReports < ActiveRecord::Migration
  def change
    create_table :zipped_reports do |t|
      t.belongs_to :project, null: false
      t.string :zipfile
      t.timestamps
    end
  end
end
