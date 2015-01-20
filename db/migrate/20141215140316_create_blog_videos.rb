class CreateBlogVideos < ActiveRecord::Migration
  def change
    create_table :blog_videos do |t|
      t.string :title
      t.text :content
      t.string :video_url
      t.string :locale
      t.boolean :published
      t.date :publish_date

      t.timestamps
    end
  end
end
