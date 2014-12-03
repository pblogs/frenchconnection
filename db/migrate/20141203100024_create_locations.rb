class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.references :certificates
      t.boolean :outdoor
      t.boolean :indoor

      t.timestamps
    end
  end
end
