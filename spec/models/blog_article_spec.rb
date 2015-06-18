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

require 'spec_helper'

describe BlogArticle do
  before do
    @blog_article = Fabricate(:blog_article)
  end

  it 'is valid from the fabric' do
    expect(@blog_article).to be_valid
  end
end
