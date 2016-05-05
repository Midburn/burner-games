if @success  
  json.partial! "api/v1/shared/correct", completed: @category_completed
else
  json.partial! "api/v1/shared/wrong"
end