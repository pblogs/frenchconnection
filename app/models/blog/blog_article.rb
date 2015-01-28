# == Schema Information
#
# Table name: blog_articles
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  locale       :string(255)
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

class BlogArticle < ActiveRecord::Base
  include Blog

  validates :title, presence: true
  validates :content, presence: true, if: -> { published }

  has_many :blog_images, as: :owner, dependent: :destroy

  accepts_nested_attributes_for :blog_images, allow_destroy: true
end
