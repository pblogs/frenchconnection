class CertificatesUsers < ActiveRecord::Migration
  def change
    create_table :certificates_users do |t|
      t.integer :certificate_id
      t.integer :user_id
    end
  end
end
