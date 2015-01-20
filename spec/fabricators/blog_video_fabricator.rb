Fabricator(:blog_video) do
  title 'Test video'
  content 'test video content'
  video_url '//www.youtube.com/embed/o0nm5Oqh6TY'
  published true
  publish_date { Time.now }
end
