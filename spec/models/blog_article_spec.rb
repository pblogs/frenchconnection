require 'spec_helper'

describe BlogArticle do
  before do
    @blog_article = Fabricate(:blog_article)
  end

  it 'is valid from the fabric' do
    expect(@blog_article).to be_valid
  end
end
