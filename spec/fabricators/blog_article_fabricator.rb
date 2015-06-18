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
#  date         :date
#  ingress      :text
#

Fabricator(:blog_article) do
  title 'Test article'
  content 'Test article content'
  ingress 'Test article ingress'
  locale 'nb'
  published true
  publish_date { Time.now }
end
