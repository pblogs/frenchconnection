# == Schema Information
#
# Table name: blog_projects
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

class BlogProject < ActiveRecord::Base
  include Blog

  validates :title, presence: true
  validates :content, presence: true, if: -> { published }

  has_many :blog_images, as: :owner, dependent: :destroy

  mount_uploader :image, DocumentUploader
end
