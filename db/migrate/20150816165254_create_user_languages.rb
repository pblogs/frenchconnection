class CreateUserLanguages < ActiveRecord::Migration
  def change
    create_table :user_languages do |t|
      t.belongs_to :user, null: false
      t.belongs_to :language, null: false
      t.integer :rating, null: false
      t.timestamps null: false
    end
  end
end
