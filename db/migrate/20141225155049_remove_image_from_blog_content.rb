class RemoveImageFromBlogContent < ActiveRecord::Migration
  def up
    remove_column :blog_articles, :image
    remove_column :blog_projects, :image
  end

  def down
    add_column :blog_articles, :image, :string
    add_column :blog_projects, :image, :string
  end
end
