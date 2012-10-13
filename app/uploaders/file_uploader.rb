class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes  

  process :set_content_type

  storage :file            

  def store_dir            
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list 
    %w(mp3 wma ogg)
  end                          

end
