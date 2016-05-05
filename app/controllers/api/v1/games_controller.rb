module Api
  module V1
    class GamesController < BaseApiController
      before_action :ensure_user_id!, only: %i(create)
      before_action :ensure_game_found!, only: %i(get update new_question answer questions hint)
      before_action :ensure_question_found!, only: %i(answer hint)
      before_action :ensure_answer_ids!, only: %i(answer)
      before_action :games_params
      before_action :ensure_category!, only: %i(new_question)

      def get
        @game
      end

      def create
        @game = Game::create_new_game(params[:user_id])
      end

      def new_question
        @question = @game.new_question(@category)
      end

      def questions
        @questions = @game.questions
      end

      def answer
        @question = Question.find(params[:question_id])
        @success = @game.user_answered(params[:question_id], params[:answer_ids])
        @category_completed = @game.categories_game.find_by(category: @question.category).completed?
      end

      def hint
        question = Question.find(params[:question_id])
        @hints = [question.corrects.sample, question.falses.sample].shuffle
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

      def ensure_category!
        return error(E_INVALID_PARAM, "missing 'category' parameter on request") if params["category"].nil?
        
        @category = Category.find_by_name(params["category"])
        return error(E_RESOURCE_NOT_FOUND, "the given category does not exist") if @category.nil?
        return error(E_INVALID_PARAM, "this category is not part of this game") unless @game.categories.include? @category
      end
    end
  end
end
