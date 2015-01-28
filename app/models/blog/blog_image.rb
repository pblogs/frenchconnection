# == Schema Information
#
# Table name: blog_images
#
#  id          :integer          not null, primary key
#  image       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  owner_type  :string(255)
#  owner_id    :integer
#  main        :boolean
#

class BlogImage < ActiveRecord::Base
  validates :image, presence: true

  belongs_to :owner, polymorphic: true

  mount_uploader :image, ImageUploader
end
