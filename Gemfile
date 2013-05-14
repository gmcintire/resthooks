source 'https://rubygems.org'

gem 'rails', '4.0.0.beta1'

gem 'active_model_serializers'
gem 'devise', git: "https://github.com/plataformatec/devise.git", branch: "rails4"
gem 'haml-rails'
gem 'httparty'
gem 'puma'
gem 'pg'
gem 'rails-observers'
gem 'sidekiq'
gem 'sinatra'
gem 'slim'

group :development, :test do
  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'foreman'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'pry'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner', github: "bmabey/database_cleaner"
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
end

group :production do
  gem 'uglifier'
end
