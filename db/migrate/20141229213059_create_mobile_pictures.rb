class CreateMobilePictures < ActiveRecord::Migration
  def change
    create_table :mobile_pictures do |t|
      t.references :task, index: true
      t.references :user, index: true
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
