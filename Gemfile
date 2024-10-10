# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem "devise"
gem "dotenv-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.8"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "pry-rails"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
end

group :development do
  gem "bullet"
end
