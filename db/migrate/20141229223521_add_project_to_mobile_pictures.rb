class AddProjectToMobilePictures < ActiveRecord::Migration
  def change
    add_reference :mobile_pictures, :project, index: true
  end
end
