# == Schema Information
#
# Table name: blog_articles
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  image        :string(255)
#  locale       :string(255)
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

class BlogArticle < ActiveRecord::Base
  include Blog

  has_many :blog_images, as: :owner, dependent: :destroy

  mount_uploader :image, DocumentUploader
end
