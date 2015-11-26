module Api
  module V1
    class QuestionsController < BaseApiController

      def create
        @question = Question.create(question_params)
      end

      private
      def question_params
        params.delete :question
        params.permit(:body, :question_type, :level, :category, answers_attributes: [:body, :answer_type], question: [:body, :question_type, :level, :category])
      end
    end
  end
end