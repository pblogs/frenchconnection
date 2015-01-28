require 'spec_helper'

describe V1::BlogArticles do
  
  # gets array of published BlogArticles
  describe 'GET /api/v1/blog_articles' do
    it 'returns published BlogArticles' do
      ba1 = Fabricate(:blog_article, published: true)
      ba2 = Fabricate(:blog_article, published: false)
      
      get "/api/v1/blog_articles"
      
      hash = JSON.parse(response.body)
      
      ids = hash['blog_articles'].collect { |a| a['id'] }
      ids.should include ba1.id
      ids.should_not include ba2.id
    end
  end

end
