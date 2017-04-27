json.call(category_game, :category_id, :name, :corrects)
json.category_completed category_game.completed?
json.questions do
  json.array! category_game.questions do |question|
    json.partial! "api/v1/questions/question", question: question
  end
end