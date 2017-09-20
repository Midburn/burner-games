namespace :midburn do

  desc "Load seed data from lib/questions_db.csv"
  task :seed_data_from_file => :environment do

    # clean the db
    Question.destroy_all
    Answer.destroy_all
    Category.destroy_all

    # create categories
    Category.find_or_create_by(name: "survival_guide")
    Category.find_or_create_by(name: "principles")
    Category.find_or_create_by(name: "orientation")
    Category.find_or_create_by(name: "leave_no_trace")
    Category.find_or_create_by(name: "safe_zone")
    Category.find_or_create_by(name: "other")

    categories_keys = {
      "1" => Category.find_by_name("survival_guide"),
      "2" => Category.find_by_name("principles"),
      "3" => Category.find_by_name("orientation"),
      "4" => Category.find_by_name("leave_no_trace"),
      "5" => Category.find_by_name("safe_zone"),
      "6" => Category.find_by_name("other")
    }

    # load questions csv
    csv = CSV.new(File.open(Rails.root.join('lib', 'questions_db.csv')))
    text = File.open(Rails.root.join('lib', 'questions_db.csv')).read
    keys = ["number", "composer", "category-number", "question", "unknown", "unknown-2", "answer"]
    array = CSV.parse(text).map { |a| Hash[keys.zip(a)] }

    array.each_with_index do |line, index|
      if line["number"] != nil
        question = Question.new(body: line["question"], question_type: "text", category: categories_keys[line["category-number"]] || Category.find_by_name("other"))
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
