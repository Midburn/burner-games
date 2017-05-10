Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/midranger', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#root', defaults: { format: 'html' }

  # webapp
  get "/webapp", to: "application#root", defaults: { format: 'html' }

  namespace :api, format: false do
    namespace :v1 do
      # games
      post "/games/new",                 to: "games#create"
      get  "/games/:token",              to: "games#get"
      get  "/games/:token/questions",    to: "games#questions"
      post "/games/:token/new_question", to: "games#new_question"
      post "/games/:token/answer",       to: "games#answer"
      post "/games/:token/hint",         to: "games#hint"
      post "/games/:token/completed",    to: "games#completed"
    end

    # match '*path', to: redirect("/api/v1/%{path}"), via: :all
  end


end