json.partial! "api/v1/shared/success"

json.session do
  json.partial! "api/v1/shared/session", session: @session
end

json.game do 
  json.partial! "api/v1/games/game", game: @game
end


# json.partial! "api/v1/shared/meta", limit: params[:limit], offset: params[:offset], total: nil
