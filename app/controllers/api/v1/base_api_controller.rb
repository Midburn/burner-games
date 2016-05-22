module Api
  module V1
    class Api::V1::BaseApiController < ActionController::Base
      # respond_to :json, except: %i()
      before_action :validate_json, unless: -> { request.get? }
      before_filter :default_format_json
      ActionController::Parameters.action_on_unpermitted_parameters = :raise
      protect_from_forgery

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
        Rails.logger.error "\n>> API Error: code: #{code}, message: #{message}\n"

        render json: {
          status: "error",
          message: message
        }, status: code
      end

      rescue_from Exception do |e|
        Rails.logger.error e.message
        error 500, e.message
      end
    end
  end
end