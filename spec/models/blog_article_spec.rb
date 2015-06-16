# == Schema Information
#
# Table name: blog_articles
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  locale       :string
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#  date         :date
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
