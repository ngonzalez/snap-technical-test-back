source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "7.0.3"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "5.6.4"

# Simple, efficient background processing for Ruby.
gem "sidekiq", "6.5.1"

# PostgreSQL
gem "pg"

# Use Redis adapter to run Action Cable in production
gem "redis"

# Redis backed store for Rack::Cache, an HTTP cache.
gem "redis-rack-cache"

# Redis for Ruby on Rails
gem "redis-rails"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Environment
gem "dotenv-rails"

# listen
gem "listen"

# Use SCSS for stylesheets
gem "sass-rails"

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks"

# Stimulus is a JavaScript framework with modest ambitions.
gem "stimulus-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Devise
gem "devise"

# Devise token authentication
gem "devise-token_authenticatable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap"

# Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.
gem "annotate"

# Dragonfly is a framework that enables on-the-fly processing for any content type.
gem "dragonfly"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "pry"

  # faker
  gem "faker"

  # factory_bot is a fixtures replacement
  gem "factory_bot_rails"

  # rspec-json_expectations
  gem "rspec-json_expectations"

  # shoulda-matchers
  gem "shoulda-matchers"

  # rspec testing framework
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: "main"
  end
end
