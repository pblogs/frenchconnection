class CertificatesInventories < ActiveRecord::Migration
  def change
    create_table :certificates_inventories do |t|
      t.integer :certificate_id
      t.integer :inventory_id
    end
  end
end
