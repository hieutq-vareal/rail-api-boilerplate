# frozen_string_literal: true

module SessionStoreApi
  module V1
    module Users
      class SessionsController < BaseController
        def login
          user = User.find_by(email: params[:email])
          raise ExceptionHandler::ApiError, { code: "403001" } unless user&.valid_password?(params[:password])

          session[:user_id] = user.id
          render_ok({ success: true, result: { user_id: user.id } })
        end

        def logout
          session[:user_id] = nil
          render_ok
        end
      end
    end
  end
end
