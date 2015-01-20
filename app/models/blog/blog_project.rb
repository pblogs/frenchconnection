class BlogProject < ActiveRecord::Base
  include Blog

  mount_uploader :image, DocumentUploader
end
