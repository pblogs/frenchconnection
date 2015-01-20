Fabricator(:blog_article) do
  title 'Test article'
  content 'Test article content'
  locale 'nb'
  published true
  publish_date { Time.now }
end
