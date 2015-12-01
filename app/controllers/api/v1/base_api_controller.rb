module Api
  module V1
    class Api::V1::BaseApiController < ActionController::Base
      ActionController::Parameters.action_on_unpermitted_parameters = :raise

      prepend_before_action :ensure_session_and_game, except: %(create_game)

      respond_to :json, except: %i()
      before_action :validate_json
      before_filter :default_format_json

      def ensure_session
        session = params[:session].strip.slice(0, SESSION_TOKEN_LENGTH) if params[:session].present?
        s = (session.present? && session.length == SESSION_TOKEN_LENGTH) ? Session.find_by(token: session) : nil
        @session = s
        error E_INVALID_SESSION, "Invalid API Session, access denied!" unless @session
      end

      def ensure_game
        @game = Game.find_by_token(params[:game_token])
        error E_ACCESS_DENIED, "Could not find this game, access denied!" unless @game
      end

      def validate_game_belongs_to_session
        error E_ACCESS_DENIED, "Game do not belongs to session, access denied!" unless @session.game == @game
      end

      def ensure_session_and_game
        ensure_session
        ensure_game
        validate_game_belongs_to_session
      end

      def validate_json
        JSON.parse(request.raw_post).deep_symbolize_keys
      rescue JSON::ParserError => e
        error E_INVALID_JSON, "Invalid JSON received"
        return
      end

      def default_format_json
        request.format = "json" unless params[:format]
      end

      def error(code = 500, message = "Internal api error")
        render json: {
          status: "error",
          message: message
        }, status: 500
      end

      rescue_from Exception do |e|
        Rails.logger.error e.message
        error 500, e.message
      end
    end
  end
end