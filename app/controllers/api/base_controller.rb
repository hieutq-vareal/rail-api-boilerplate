# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    include ResponseHandler
    include ExceptionHandler
  end
end
