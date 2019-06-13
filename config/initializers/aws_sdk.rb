keys = Rails.application.credentials[:aws]
creds = Aws::Credentials.new(keys[:access_key_id], keys[:secret_access_key])
Aws::Rails.add_action_mailer_delivery_method(:aws_sdk, credentials: creds, region: "us-east-1")