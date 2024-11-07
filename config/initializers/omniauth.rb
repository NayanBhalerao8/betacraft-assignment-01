# config/initializers/omniauth.rb
Dotenv.load

Devise.setup do |config|
  config.omniauth :google_oauth2, 
                  ENV['GOOGLE_OAUTH_CLIENT_ID'], 
                  ENV['GOOGLE_OAUTH_CLIENT_SECRET'], 
                  {
                    scope: 'email,profile',
                    prompt: 'select_account'
                  }
end
