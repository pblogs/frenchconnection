class CreateTinymceAssets < ActiveRecord::Migration
  def change
    create_table :tinymce_assets do |t|
      t.string :image
      t.string :description

      t.timestamps
    end
  end
end
