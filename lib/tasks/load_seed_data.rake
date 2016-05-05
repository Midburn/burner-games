namespace :midburn do

  desc "Load seed data from lib/questions_db.csv"
  task :seed_data => :environment do

    # create categories
    Category.find_or_create_by(name: "other")
    Category.find_or_create_by(name: "inclusion")
    Category.find_or_create_by(name: "gifting")
    Category.find_or_create_by(name: "decommodification")
    Category.find_or_create_by(name: "radical_self_reliance")
    Category.find_or_create_by(name: "radical_self_expression")
    Category.find_or_create_by(name: "communal_effort")
    Category.find_or_create_by(name: "civic_responsibility")
    Category.find_or_create_by(name: "leaving_no_trace")
    Category.find_or_create_by(name: "participation")
    Category.find_or_create_by(name: "immediacy")    

    # load questions csv
    csv = CSV.new(File.open(Rails.root.join('lib', 'questions_db.csv')))
    text = File.open(Rails.root.join('lib', 'questions_db.csv')).read
    keys = ["number", "auther", "topic", "question", "answer"]
    array = CSV.parse(text).map { |a| Hash[keys.zip(a)] }

    array.each_with_index do |line, index|
      if line["number"] != nil
        question = Question.new(body: line["question"], question_type: "text", category: Category::random)
      else
        question = Question.last
      end
      puts "Index: #{index}"
      puts "Line: #{line}"
      puts "Question: #{question.body}" 
      puts "--------------------------------------------------------------------------------------------------------"

      answer = Answer.new(body: line["answer"] || "missing answer :(", answer_type: "text")
      question.answers << answer
      question.save

      # assumes every 4th answer is correct answer. 
      # You're on your own if you wanna make something else.
      # It's fine for testing by does not cover cases of less or more answers
      if (index+1) % 4 == 0
        question.mark_correct_answer(answer)
      end
    end
  end
end
