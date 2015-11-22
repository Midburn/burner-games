json.partial! "api/v1/shared/success"
json.partial! "api/v1/shared/meta", limit: params[:limit], offset: params[:offset], total: nil
json.games do
  json.array! @games do |game|
    json.partial! "api/v1/games/game", game: game
  end
end
