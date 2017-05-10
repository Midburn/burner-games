source 'https://rubygems.org'

ruby "2.4.1"

gem 'rails', '4.2.5'              # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails-api'                   # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sass-rails', '~> 4.0.3'      # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'        # Use Uglifier as compressor for JavaScript assets
gem 'jbuilder', '~> 2.0'          # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'mysql2', '~> 0.3.18'

gem 'rack-cors', :require => 'rack/cors' # Rack CORS Middleware

# managment system
gem 'rails_admin', '~> 0.7.0'     # Backoffice Rails data administration system

group :doc do
  gem 'sdoc', '~> 0.4.0'          # bundle exec rake doc:rails generates the API under doc/api.
end

group :development, :test do
  gem "webmock"                   # WebMock allows stubbing HTTP requests and setting expectations on HTTP requests
  gem 'spring'                    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "database_cleaner"          # Strategies for cleaning databases
  # gem "rspec"                   # DISABLED FOR NOW: will be added later
  # gem 'rspec-rails', '~> 3.0'   # DISABLED FOR NOW: will be added later
  gem "factory_girl_rails"        # Create factories
  gem "fuubar"                    # The instafailing RSpec progress bar formatter
  # gem "guard"                   # DISABLED FOR NOW: Guard is a command line tool to easily handle events on file system modifications.
  # gem "guard-rspec"             # DISABLED FOR NOW: Guard::RSpec automatically run your specs (much like autotest).
  gem "pry"
  gem "pry-doc"
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'dotenv-rails'
end

group :production, :staging do
  gem 'rails_12factor'
  gem "pg"
end
