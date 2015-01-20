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

Fabricator(:blog_video) do
  title 'Test video'
  content 'test video content'
  video_url '//www.youtube.com/embed/o0nm5Oqh6TY'
  published true
  publish_date { Time.now }
end
