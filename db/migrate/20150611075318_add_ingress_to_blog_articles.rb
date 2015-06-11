class AddIngressToBlogArticles < ActiveRecord::Migration
  def change
    add_column :blog_articles, :ingress, :text
  end
end
