class AddImageOwnerToBlogImages < ActiveRecord::Migration
  def up
    add_column :blog_images, :owner_type, :string
    add_column :blog_images, :owner_id, :integer
  end

  def down
    remove_column :blog_images, :owner_type
    remove_column :blog_images, :owner_id
  end
end
