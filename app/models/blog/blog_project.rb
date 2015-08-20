# == Schema Information
#
# Table name: blog_projects
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  locale       :string
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

class BlogProject < ActiveRecord::Base
  include Blog

  validates :title, presence: true
  validates :content, presence: true, if: -> { published }

  has_many :blog_images, as: :owner, dependent: :destroy

  accepts_nested_attributes_for :blog_images, allow_destroy: true
end
