class AddYearToMonthlyReports < ActiveRecord::Migration
  def change
    add_column :monthly_reports, :year, :integer
  end
end
