json.call(question, :id, :body, :question_type, :level, :category)

json.answers do
  json.array! question.answers.shuffle do |answer|
    json.partial! "api/v1/answers/answer", answer: answer
  end
end
