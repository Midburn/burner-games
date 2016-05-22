json.response @success
json.category_completed @categoryGame.completed?
json.game_completed @game_completed

unless @success
  json.correct_answers do
    json.array! @question.corrects do |answer|
      json.partial! "api/v1/answers/answer", answer: answer
    end
  end
end