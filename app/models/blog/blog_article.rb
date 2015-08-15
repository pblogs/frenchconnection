# == Schema Information
#
# Table name: blog_articles
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  locale       :string
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#  date         :date
#  ingress      :text
#

class BlogArticle < ActiveRecord::Base
  include Blog

  validates :title,   presence: true
  validates :content, presence: true, if: -> { published }
  validates :ingress, presence: true, if: -> { published }

  validates_length_of :title,   maximum: 47
  validates_length_of :ingress, maximum: 128, if: -> { published }

  has_many :blog_images, as: :owner, dependent: :destroy

  accepts_nested_attributes_for :blog_images, allow_destroy: true
end
