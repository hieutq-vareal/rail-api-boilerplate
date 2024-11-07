# frozen_string_literal: true

module Api
  module V1
    class HomeController < BaseController
      def index
        raise ExceptionHandler::ApiError, { code: "400001" }
      end
    end
  end
end
