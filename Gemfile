source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'api_annotation'#, git: 'https://github.com/GustavoFZS/api_annotation.git'
gem 'api_docs'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'rails', '6.1.2.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '4.0.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]