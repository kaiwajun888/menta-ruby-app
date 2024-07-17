class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg gif png webp)
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("user_hoso.png")
  end

  process resize_to_fill: [200, 200]

  version :thumb do
    process resize_to_fill: [50, 50]
  end
end
