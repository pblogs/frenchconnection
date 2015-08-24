class CreateUserLanguages < ActiveRecord::Migration
  def change
    create_table :user_languages do |t|
      t.belongs_to :user
      t.belongs_to :language
      t.integer :rating
      t.timestamps null: false
    end
  end
end
