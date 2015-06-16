class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.json :data
      t.references :dynamic_form, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
