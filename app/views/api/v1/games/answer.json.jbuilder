if @success  
  json.partial! "api/v1/shared/correct"
else
  json.partial! "api/v1/shared/wrong"
end