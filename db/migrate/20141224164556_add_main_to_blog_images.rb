class AddMainToBlogImages < ActiveRecord::Migration
  def up
    add_column :blog_images, :main, :boolean
  end

  def down
    remove_column :blog_images, :main
  end
end
