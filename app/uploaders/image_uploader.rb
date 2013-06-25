# encoding: utf-8
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mime_types'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes
  process :set_content_type
  storage :file

  def store_dir
    'uploads/product/image/'
  end

  version :image do
    process :resize_to_fill => [100, 100]
  end
  
  version :large do
    process :resize_to_fill => [640, 300]
  end
  
  version :thumb do
    process :resize_to_fill => [40, 40]
  end

  version :small do
    process :resize_to_fill => [10, 10]
  end
end
