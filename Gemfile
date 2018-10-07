source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'jbuilder', '~> 2.5'
gem 'slim-rails', '3.1.1'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'factory_girl_rails'
  gem 'spring-commands-rspec'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'bullet'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
end

group :test do
  gem 'database_rewinder'
  gem 'capybara'
  gem 'rspec_junit_formatter'
  gem 'guard-rspec', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
