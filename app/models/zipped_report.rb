class ZippedReport < ActiveRecord::Base
  mount_uploader :zipfile, ZipfileUploader

  belongs_to :project
end
