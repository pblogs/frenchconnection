module V1
  module Entities

    class BlogArticles < Grape::Entity
      expose :id, :title, :content, :blog_images, :locale, :publish_date
      
    end

  end
end
