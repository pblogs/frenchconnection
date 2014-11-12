# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  document   :string(255)
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Attachment < ActiveRecord::Base
  validates :document, :presence => true
  validates :project,  :presence => true

  belongs_to :project
  mount_uploader :document, DocumentUploader
end
