module Api
  module V1
    class GamesController < BaseApiController
      before_action :ensure_user_id!, only: %i(create)
      before_action :ensure_game_found!, only: %i(get update)
      before_action :games_params

      def get
        @game
      end

      def create
        @game = Game.new user_id: params[:user_id]
        @game.save!

        @game.ensure_only_one_active_game
      end

      def update
        @game
      end

      private
      def ensure_user_id!
        params.require(:user_id)
      end

      def ensure_game_found!
        @game = Game.find_by token: params[:token]
        return error(E_RESOURCE_NOT_FOUND, "could not find game with token '#{params[:token]}'") if @game.blank?
      end

      def games_params
        params["game"].permit :user_id
      end
    end
  end
end
