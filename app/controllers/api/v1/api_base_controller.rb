module Api
  module V1
    class ApiBaseController < ApplicationController
      before_action :validate_json
    end
  end
end