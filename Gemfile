source 'https://rubygems.org'

gem 'rails', '4.2.0'#'4.0.3'
gem 'rack'

gem 'mysql2'

gem 'sass-rails'#, '5.0.1'#'~> 4.0.0'

#gem 'omniauth' #, '1.1.0'
#gem 'omniauth-google-oauth2', :require => 'omniauth/google_oauth2' #, :git => 'https://github.com/zquestz/omniauth-google-oauth2.git'
#gem 'google-api-client', :require => 'google/api_client'

# Gems used only for assets and not required
# in production environments by default.
gem 'coffee-rails'#, '4.1.0'#'~> 4.0.0'
gem 'therubyracer'
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'uglifier' #, '>= 1.0.3'

gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem "compass-rails", "~> 2.0.alpha.0"

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Gems for login
gem 'devise'
gem 'devise_invitable'
gem 'devise-i18n'
gem 'rolify'
gem 'cancan'
# Encryption du mot de passe
gem 'bcrypt-ruby'
gem 'bcrypt', '~> 3.1.7'

# Gem for validation if teacher is available
#gem 'acts_as_bookable', git: 'git@github.com:groupefungo/acts_as_bookable'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'cucumber-rails', :require => false, group: [:test]
  gem 'database_cleaner', group: [:test]
  gem 'factory_girl_rails', group: [:test]
  gem 'capybara', group: [:test]
  gem 'rspec', group: [:test]
  gem 'rspec-rails', group: [:test]
  gem 'simplecov', :require => false, :group => :test
end