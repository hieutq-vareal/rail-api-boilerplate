# frozen_string_literal: true

module SessionStoreApi
  class AuthenticationController < BaseController
    before_action :authenticated_user!

    private

    def authenticated_user!
      return true if current_user.present?

      raise ExceptionHandler::ApiError, { code: "403001" }
    end
  end
end
