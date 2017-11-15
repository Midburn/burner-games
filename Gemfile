source 'https://rubygems.org'

ruby "2.4.2"

gem 'rails', '~> 5.1.4'           # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'jbuilder'
gem "pg"
gem 'dotenv-rails', groups: [:development, :test]

gem 'rack-cors', :require => 'rack/cors' # Rack CORS Middleware

# managment system
gem 'rails_admin', '~> 1.2'     # Backoffice Rails data administration system

# rest api calls
gem 'httparty'

group :doc do
  gem 'sdoc', '~> 0.4.0'          # bundle exec rake doc:rails generates the API under doc/api.
end

group :development, :test do
  gem "webmock"                   # WebMock allows stubbing HTTP requests and setting expectations on HTTP requests
  gem "database_cleaner"          # Strategies for cleaning databases
  gem "pry"
  gem "pry-doc"
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

group :production, :staging do
  gem 'rails_12factor'
end
