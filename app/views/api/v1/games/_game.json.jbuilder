json.call(game, :token, :status, :user_id, :answered_correctly, :questions_count)

json.categories do
  json.array! @game.categories_game do |cg|
    json.partial! "api/v1/categories/categories_game", category_game: cg
  end
end