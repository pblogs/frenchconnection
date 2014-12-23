# == Schema Information
#
# Table name: tinymce_assets
#
#  id          :integer          not null, primary key
#  image       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class BlogImage < ActiveRecord::Base
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
