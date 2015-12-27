module Api
  module V1
    class GamesController < BaseApiController
      before_action :ensure_user_id!, only: %i(create)
      before_action :ensure_game_found!, only: %i(get update new_question answer questions)
      before_action :ensure_question_found!, only: %i(answer)
      before_action :ensure_answer_ids!, only: %i(answer)
      before_action :games_params

      def get
        @game
      end

      def create
        @game = Game.new user_id: params[:user_id]
        @game.save!

        @game.ensure_only_one_active_game
      end

      def new_question
        @question = @game.new_question(params[:level] || "easy")
      end

      def questions
        @questions = @game.questions
      end

      def answer
        @success = @game.user_answered(params[:question_id], params[:answer_ids])
      end

      def update
        @game
      end

      private
      def ensure_user_id!
        params.require(:user_id)
      end

      def ensure_answer_ids!
        params.require(:answer_ids)
      end

      def ensure_game_found!
        @game = Game.find_by token: params[:token]
        return error(E_RESOURCE_NOT_FOUND, "could not find game with token '#{params[:token]}'") if @game.blank?
      end

      def ensure_question_found!
        return error(E_INVALID_PARAM, "could not find this question in this game") unless @game.questions.include? Question.find(params[:question_id])
      end

      def games_params
        params["game"].permit :user_id
      end
    end
  end
end
