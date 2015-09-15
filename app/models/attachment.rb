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
  belongs_to :attachable, polymorphic: true

  validates :document, presence: true
  validates :attachable,  presence: true

  mount_uploader :document, DocumentUploader
end
