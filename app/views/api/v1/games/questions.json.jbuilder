json.game do
  json.partial! "api/v1/games/game", game: @game

  json.questions do
    json.array! @questions do |question|
      json.partial! "api/v1/questions/question", question: question
    end
  end
end
