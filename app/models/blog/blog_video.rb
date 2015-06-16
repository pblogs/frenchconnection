# == Schema Information
#
# Table name: blog_videos
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  video_url    :string
#  locale       :string
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

class BlogVideo < ActiveRecord::Base
  include Blog

  validates :title, presence: true
  validates :content, presence: true, if: -> { published }
  validates :video_url, presence: true, if: -> { published }

end
