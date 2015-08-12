class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.references :users
      t.string :name
      t.date :birth_date
      t.boolean :sole_custody

      t.timestamps null: false
    end
  end
end
