# Register the new question menu item
require Rails.root.join('lib', 'rails_admin', 'add_new_question.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::AddNewQuestion)

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete

    add_new_question
    
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
