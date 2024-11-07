# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < BaseController
        # login
        def create
          user = User.find_by(email: params[:email])
          raise ExceptionHandler::ApiError, { code: "403001" } unless user&.valid_password?(params[:password])

          session[:user_id] = user.id
          @access_token = JsonWebToken.encode(user_id: user.id)
          new_refresh_token = user.create_refresh_token!
          @refresh_token = new_refresh_token.crypted_token
        end

        # logout
        def destroy
          current_user&.refresh_token&.destroy
          session[:user_id] = nil
          render_ok
        end

        def refresh_token
          raise ExceptionHandler::ApiError, { code: "400001" } if params[:refresh_token].blank?

          new_refresh_token = RefreshToken.renew_token!(params[:refresh_token])
          @refresh_token = new_refresh_token.crypted_token
          @access_token = JsonWebToken.encode(user_id: new_refresh_token.user_id)
        end
      end
    end
  end
end
