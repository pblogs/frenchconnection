class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user
      t.references :favorable, polymorphic: true
      t.timestamps
    end
  end
end
