csv = CSV.new(File.open(Rails.root.join('lib', 'questions_db.csv')))
text = File.open(Rails.root.join('lib', 'questions_db.csv')).read
keys = ["number", "auther", "topic", "question", "answers"]
array = CSV.parse(text).map { |a| Hash[keys.zip(a)] }

array.each_with_index do |line, index|

  if line["number"] != nil
    question = Question.new(body: line["question"], question_type: "text")
  else
    question = Question.last
  end
  puts "Index: #{index}"
  puts "Line: #{line}"
  puts "Question: #{question.body}" 
  puts "--------------------------------------------------------------------------------------------------------"

  answer = Answer.new(body: line["answers"] || "missing answer :(", answer_type: "text")
  question.answers << answer
  question.save

  if (index+1) % 4 == 0
    question.mark_correct_answer(answer)
  end
  puts "--------------------------------------------------------------------------------------------------------"
end