class BlogArticle < ActiveRecord::Base
  include Blog

  mount_uploader :image, DocumentUploader
end
