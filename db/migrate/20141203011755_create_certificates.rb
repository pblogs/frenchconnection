class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates, force: true do |t|
      t.string :title
      t.timestamps
    end
  end
end
