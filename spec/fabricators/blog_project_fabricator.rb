Fabricator(:blog_project) do
  title 'Test blog project'
  content 'Test blog project content'
  locale 'nb'
  published true
  publish_date { Time.now }
end
