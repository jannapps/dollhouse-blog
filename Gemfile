source "https://rubygems.org"

ruby "3.2.9"

# Core Rails framework
gem "rails", "8.1.1"

# Database
gem "sqlite3", "~> 2.1"

# Web server
gem "puma", "~> 7.1"

# Asset pipeline
gem "propshaft", "~> 1.0"

# JavaScript and CSS
gem "importmap-rails", "~> 2.0"
gem "turbo-rails", "~> 2.0"
gem "stimulus-rails", "~> 1.3"

# JSON APIs
gem "jbuilder", "~> 2.12"

# Performance
gem "bootsnap", "~> 1.18", require: false

# Markdown processing
gem "redcarpet", "~> 3.6"

# Windows timezone support
gem "tzinfo-data"

group :development, :test do
  # Debugging
  gem "debug", "~> 1.11", platforms: %i[ mri windows ], require: "debug/prelude"

  # Security auditing (latest: 0.9.2, supports Ruby 3.2+)
  gem "bundler-audit", "~> 0.9.2", require: false

  # Static analysis for security vulnerabilities (latest: 7.1.0, requires Ruby 3.1+)
  gem "brakeman", "~> 7.1", require: false

  # Code linting and formatting (latest: 1.1.0)
  gem "rubocop-rails-omakase", "~> 1.1", require: false
end

group :development do
  # Console on exceptions
  gem "web-console", "~> 4.2"
end

group :test do
  # System testing (Capybara 3.40.0 requires Ruby 3.0+, selenium-webdriver 4.30+)
  gem "capybara", "~> 3.40"
  gem "selenium-webdriver", "~> 4.30"
end
