RailsAdmin.config do |config|

  # More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == ENV["RAILS_ADMIN_USERNAME"] && password == ENV["RAILS_ADMIN_PASSWORD"]
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    
    # member actions
    show
    edit
    delete
    show_in_app
  end

  # Exclude Rails though models. They should never be edited by a user.
  # config.excluded_models << GamesQuestions
  config.excluded_models << UserAnswer

end
