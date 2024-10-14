# frozen_string_literal: true

module SessionStoreApi
  class BaseController < ApplicationController
    include ResponseHandler
    include ExceptionHandler

    private

    def current_user
      User.find_by(id: session[:user_id])
    end
  end
end
