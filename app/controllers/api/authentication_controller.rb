# frozen_string_literal: true

module Api
  class AuthenticationController < BaseController
    before_action :authenticated_user!

    private

    def authenticated_user!
      return if authenticated?

      raise ExceptionHandler::ApiError, { code: "403001" }
    end

    def authenticated?
      authorization_token = extract_token(request.headers["Authorization"]) ||
                            extract_token(request.headers["X-Authorization"])
      return false if authorization_token.blank?

      begin
        data = JsonWebToken.decode(authorization_token)
        user = User.find_by(id: data[:user_id])
        return false if user.blank?

        session[:user_id] = user.id
        true
      rescue JWT::ExpiredSignature
        raise ExceptionHandler::ApiError, { code: "401001" }
      end
    end

    def extract_token(header)
      header.to_s[/Bearer (\S+)/, 1]
    end
  end
end
