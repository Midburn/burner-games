json.response "wrong"

json.correct_answers do
  json.array! @question.corrects do |answer|
    json.partial! "api/v1/answers/answer", answer: answer
  end
end
