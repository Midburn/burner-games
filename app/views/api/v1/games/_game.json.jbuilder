json.call(game, :token, :status, :user_id, :answered_correctly, :questions_count)
json.categories do
  json.array! @game.games_categories
end
