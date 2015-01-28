module V1
  module Entities
    class BlogProjects < Grape::Entity
      expose :id, :title, :content, :blog_images, :locale, :publish_date
    end
  end
end
