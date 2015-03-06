class RenameCertificatesUsersToUserCertificates < ActiveRecord::Migration
  def change
    rename_table :certificates_users, :user_certificates
  end
end
