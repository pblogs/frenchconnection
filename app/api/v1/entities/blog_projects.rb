module V1
  module Entities
    class BlogProjects < Grape::Entity
      expose :id, :title, :content, :blog_images, :locale, :created_at
    end
  end
end
