class GamesQuestions < ApplicationRecord
  belongs_to :game
  belongs_to :question

  # questions should not repeat on the same game
  validates :questions, uniqueness: { scope: [:game, :question] }
end
