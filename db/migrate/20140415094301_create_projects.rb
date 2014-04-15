class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_number
      t.string :name
      t.references :company, index: true

      t.timestamps
    end
  end
end
