class BlogProject < ActiveRecord::Base
  scope :published, -> { where('published = :published and publish_date <=
                                :date', published: true, date: Date.today)
                                  .order('publish_date DESC') }

  mount_uploader :image, DocumentUploader
end
