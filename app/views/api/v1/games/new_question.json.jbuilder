unless @game_ended
  json.partial! "api/v1/questions/question", question: @question  
else
  json.partial! "api/v1/shared/success"
end
