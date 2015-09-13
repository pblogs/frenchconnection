class PolymorphicAttachments < ActiveRecord::Migration
  def change
    remove_column :attachments, :project_id, :integer
    add_column :attachments, :attachable_id, :integer
    add_column :attachments, :attachable_type, :string
  end
end
