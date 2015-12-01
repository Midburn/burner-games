module Api
  module V1
    SESSION_TOKEN_LENGTH = 22
    
    STATUS_OK = "ok"
    STATUS_ERROR = "error"

    E_INVALID_JSON = 1
    E_INVALID_SESSION = 2
    E_ACCESS_DENIED = 3
    E_RESOURCE_NOT_FOUND = 4
    E_INVALID_PARAM = 5
    E_INTERNAL = 6

    VERSION = "0.1.0"

    class CatchJsonParseErrors
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      rescue ActionDispatch::ParamsParser::ParseError => error
        return [
          500,
          { "Content-Type" => "application/json" },
          [{ status: STATUS_ERROR, error_no: E_INVALID_JSON, message: "There was a problem in the JSON you submitted" }.to_json]
        ]
      end
    end
  end
end
