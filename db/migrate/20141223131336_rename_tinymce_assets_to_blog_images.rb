class RenameTinymceAssetsToBlogImages < ActiveRecord::Migration
  def up
    rename_table :tinymce_assets, :blog_images
  end

  def down
    rename_table :blog_images, :tinymce_assets
  end
end
