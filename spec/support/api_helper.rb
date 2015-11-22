module ApiHelper
  def api_call(type, route, params)
    # perform Rack::Test post, get, put, delete calls to #{route} with params.to_json
    method(type).call route, params.to_json
  end
end
