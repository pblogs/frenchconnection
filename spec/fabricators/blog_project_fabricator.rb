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

Fabricator(:blog_project) do
  title 'Test blog project'
  content 'Test blog project content'
  locale 'nb'
  published true
  publish_date { Time.now }
end
