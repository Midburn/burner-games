module Api
  module V1
    class Api::V1::BaseApiController < ActionController::Base
      respond_to :json, except: %i()
      before_action :validate_json
      before_filter :default_format_json
      ActionController::Parameters.action_on_unpermitted_parameters = :raise

      protect_from_forgery
      before_filter :cors_preflight_check
      after_filter :cors_set_access_control_headers

      # For all responses in this controller, return the CORS access control headers.
      def cors_set_access_control_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
          headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
          headers['Access-Control-Max-Age'] = "1728000"
      end

      def cors_preflight_check
        if request.method == "OPTIONS"
          headers['Access-Control-Allow-Origin'] = 'http://localhost'
          headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
          headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
          headers['Access-Control-Max-Age'] = '1728000'
          render :text => '', :content_type => 'text/plain'
        end
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