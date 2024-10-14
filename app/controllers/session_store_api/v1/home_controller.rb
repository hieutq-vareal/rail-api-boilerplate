# frozen_string_literal: true

module SessionStoreApi
  module V1
    class HomeController < BaseController
      def index
        binding.pry
        raise ExceptionHandler::ApiError, { code: "400001" }
      end
    end
  end
end
