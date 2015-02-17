class CreateMonthlyReports < ActiveRecord::Migration
  def change
    create_table :monthly_reports do |t|
      t.string :document
      t.integer :user_id

      t.timestamps
    end
  end
end
