class CertificatesLocations < ActiveRecord::Migration
  def change
    create_table :certificates_locations do |t|
      t.integer :certificate_id
      t.integer :location_id
    end
  end
end
