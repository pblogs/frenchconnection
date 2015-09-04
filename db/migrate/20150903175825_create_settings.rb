class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :project_numbers, default: :automatic
      t.string :enable_project_reference_field, default: false

      t.timestamps null: false
    end
  end
end
