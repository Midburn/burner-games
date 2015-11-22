class ApplicationController < ActionController::Base
  # include ActionController::Serialization

  respond_to :json, except: %i(root)
  # before_filter :default_format_json

  def default_format_json
    request.format = "json" unless params[:format]
  end

  def validate_json
    JSON.parse(request.raw_post).deep_symbolize_keys
  rescue JSON::ParserError => e
    error E_INVALID_JSON, "Invalid JSON received"
    return
  end

  rescue_from Exception do |e|
    Rails.logger.error e.message
    error 500, e.message
  end

  def root
  end

  def error(code = 500, message = "Internal api error")
    render json: {
      status: "error",
      message: message
    }, status: 500
  end
end