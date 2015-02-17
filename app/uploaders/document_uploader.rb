class DocumentUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog  
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

end
