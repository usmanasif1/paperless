CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAIRXKHFZK4X3XG4WQ',                        # required
    aws_secret_access_key: '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',                        # required
    scheme: 'http'
  }
  config.fog_directory  = 'devsinc-bucket'                          # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_authenticated_url_expiration = 24.hours
end
