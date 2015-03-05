class UserCertificate < ActiveRecord::Base
  belongs_to :user
  belongs_to :certificate
  validates :user_id, presence: true
  validates :certificate_id, presence: true

  mount_uploader :image, CertificateUploader
end
