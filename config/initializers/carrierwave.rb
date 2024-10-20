require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                                 # Proveedor
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],              # Clave de acceso
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],          # Clave secreta
    region:                ENV['AWS_REGION'],                     # Región
  }
  config.fog_directory  = ENV['AWS_BUCKET_NAME']                  # Nombre del bucket
  config.fog_public     = true                                    # Opcional: hace que los archivos sean públicos (ajusta según tu preferencia)
  config.storage        = :fog                                    # Asegurarse de que el almacenamiento sea en S3
  config.cache_storage  = :file                                   # Caché local para CarrierWave
end
