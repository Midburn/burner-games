if @success  
  json.partial! "api/v1/shared/correct"
else
  json.partial! "api/v1/shared/wrong"
end
json.game do
  json.partial! "api/v1/games/game", game: @game
end
