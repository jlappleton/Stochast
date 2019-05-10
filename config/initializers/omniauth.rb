Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, Rails.application.credentials.goog[:client_id], Rails.application.credentials.goog[:client_secret]
    OmniAuth.config.full_host = Rails.env.production? ? 'https://jltav.com' : 'https://stochast-jpltn.c9users.io'
end 