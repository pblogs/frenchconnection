class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.string :title
      t.text :content
      t.string :image
      t.string :locale
      t.boolean :published
      t.date :publish_date

      t.timestamps
    end
  end
end
