class AddDateToBlogArticle < ActiveRecord::Migration
  def change
    add_column :blog_articles, :date, :date
  end
end
