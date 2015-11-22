FactoryGirl.define do
  factory :question, :class => 'Question' do
    question_text "MyString"
    type 1
    level 1
    category "MyString"
  end
end
