class AddImageToUserCertificates < ActiveRecord::Migration
  def change
    add_column :user_certificates, :image, :string
  end
end
