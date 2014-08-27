class Attachment < ActiveRecord::Base
  belongs_to :project
  mount_uploader :document, DocumentUploader
end
