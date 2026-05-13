# frozen_string_literal: true

source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'rails', '~> 8.0.3'

gem 'bootsnap', require: false
gem 'pg', '~> 1.6'
gem 'puma', '~> 7.0'
gem 'rack-cors'

# json 3.x drops the quirks_mode option ActiveSupport 8.0 still passes when encoding.
gem 'json', '~> 2.10'

gem 'active_model_serializers', '~> 0.10.15'
gem 'devise_token_auth', '~> 1.2'
gem 'dotenv-rails'
gem 'pundit', '~> 2.4'

# Serves swagger/v1/swagger.yaml (generated from spec/requests/api) and Swagger UI at /api-docs.
gem 'rswag-api'
gem 'rswag-ui'
# Leaves Ruby's default gems in 4.0; rswag-ui requires it.
gem 'ostruct'

gem 'tzinfo-data', platforms: %i(windows jruby)

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: %i(mri windows)
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 8.0'
  gem 'rswag-specs'
  gem 'shoulda-matchers'
end

group :development do
  gem 'letter_opener_web'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end
