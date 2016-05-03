json.hints do
  json.array! @hints do |hint|
    json.partial! "api/v1/answers/answer", answer: hint
  end
end
