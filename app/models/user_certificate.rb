class UserCertificate < ActiveRecord::Base
  belongs_to :user
  belongs_to :certificate

  mount_uploader :image, CertificateUploader
end
