class AddDescriptionToAttachments < ActiveRecord::Migration
  def up
    add_column :attachments, :description, :text
  end

  def down
    remove_column :attachments, :description
  end
end
