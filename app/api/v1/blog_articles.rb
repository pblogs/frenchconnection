module V1
  class BlogArticles < Base
    resource :blog_articles do 
      desc "Get all BlogArticles"
      get do
        published_articles = 
          BlogArticle.where(published: true).all

        present :blog_articles, published_articles, 
                with: V1::Entities::BlogArticles
        
        header 'Access-Control-Allow-Origin', '*'
      end  
    end
  end
end
