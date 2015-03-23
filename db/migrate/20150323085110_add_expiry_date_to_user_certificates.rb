class AddExpiryDateToUserCertificates < ActiveRecord::Migration
  def change
    add_column :user_certificates, :expiry_date, :date
  end
end
