source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.2.1'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use Puma as the app server
gem 'puma', '~> 6.4', '>= 6.4.2'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.3'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

gem 'pg', '~> 1.5'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.2'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.18.3', require: false

gem 'dotenv-rails', '~> 3.1', '>= 3.1.4'
gem 'rack-cors'

# gem 'sentry-raven', '~> 3.1'
gem 'sentry-ruby', '~> 5.20', '>= 5.20.1'
gem 'sentry-rails', '~> 5.20', '>= 5.20.1'

gem 'sidekiq', '~> 7.3', '>= 7.3.2'
gem 'sidekiq-scheduler', '~> 5.0', '>= 5.0.6'

gem 'strong_migrations', '~> 2.0'

group :development, :test do
  gem 'bullet', '~> 7.2'
  gem 'faker', '~> 3.4', '>= 3.4.2'

  gem 'rspec', '~> 3.13'
  gem 'rspec-rails', '~> 7.0', '>= 7.0.1'

  gem 'seedbank', '~> 0.5.0'
  gem 'letter_opener', '~> 1.10'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.2', '>= 4.2.1'
  gem 'listen', '~> 3.9'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 4.2', '>= 4.2.1'
  gem 'spring-watcher-listen', '~> 2.1'

  gem 'annotate', '~> 3.2'
end

group :test do
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'shoulda-matchers', '~> 5.0'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.40'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '~> 5.3', '>= 5.3.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2024', '>= 1.2024.2', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "sass-rails", "~> 6.0"


gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem "omniauth-rails_csrf_protection", "~> 1.0"