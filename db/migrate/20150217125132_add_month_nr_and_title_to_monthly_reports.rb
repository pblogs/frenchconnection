class AddMonthNrAndTitleToMonthlyReports < ActiveRecord::Migration
  def change
    add_column :monthly_reports, :month_nr, :integer
    add_column :monthly_reports, :title, :string
  end
end
