# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  document    :string
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

# A project can have many attachments. Documents, images, etc.
class Attachment < ActiveRecord::Base
  validates :document, :presence => true
  validates :project,  :presence => true

  belongs_to :project
  mount_uploader :document, DocumentUploader
end
