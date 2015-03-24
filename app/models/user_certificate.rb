class UserCertificate < ActiveRecord::Base
  belongs_to :user
  belongs_to :certificate

  validates :user_id,        presence: true
  validates :certificate_id, presence: true
  validates :expiry_date,    presence: true
  validates :image,          presence: true unless Rails.env.test?

  mount_uploader :image, CertificateUploader

  def title
    certificate.title
  end

end
