# == Schema Information
#
# Table name: blog_videos
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  video_url    :string(255)
#  locale       :string(255)
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

class BlogVideo < ActiveRecord::Base
  include Blog

  validates :title, presence: true
  validates :content, presence: true
  validates :video_url, presence: true

end
