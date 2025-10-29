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

# Windows timezone support
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  # Debugging
  gem "debug", "~> 1.11", platforms: %i[ mri windows ], require: "debug/prelude"
end

group :development do
  # Console on exceptions
  gem "web-console", "~> 4.2"
end