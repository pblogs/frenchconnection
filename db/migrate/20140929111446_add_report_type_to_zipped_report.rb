class AddReportTypeToZippedReport < ActiveRecord::Migration
  def change
    add_column :zipped_reports, :report_type, :string
  end
end
