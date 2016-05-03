Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/midranger', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#root', defaults: { format: 'html' }

  # webapp
  get "/webapp", to: "application#root", defaults: { format: 'html' }

  # static pages that were made on the midburn hackaton
  get '/help-pop-up', to: redirect('/midburn-hackaton/help-pop-up/index.html')
  get '/home-page', to: redirect('/midburn-hackaton/home-page/index.html')
  get '/image-answer', to: redirect('/midburn-hackaton/image-answer/index.html')
  get '/image-question', to: redirect('/midburn-hackaton/image-question/index.html')
  get '/right-answer-pop-up', to: redirect('/midburn-hackaton/right-answer-pop-up/index.html')
  get '/successes-pop-up', to: redirect('/midburn-hackaton/successes-pop-up/index.html')
  get '/text-question', to: redirect('/midburn-hackaton/text-question/index.html')
  get '/wrong-answer-pop-up', to: redirect('/midburn-hackaton/wrong-answer-pop-up/index.html')

  namespace :api, format: false do
    namespace :v1 do
      # games
      post "/games/new",                 to: "games#create"
      get  "/games/:token",              to: "games#get"
      get  "/games/:token/questions",    to: "games#questions"
      post "/games/:token/new_question", to: "games#new_question"
      post "/games/:token/answer",       to: "games#answer"
      post "/games/:token/hint",         to: "games#hint"
    end

    # match '*path', to: redirect("/api/v1/%{path}"), via: :all
  end


end