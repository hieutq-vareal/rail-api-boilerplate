# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class ApiError < StandardError
    attr_reader :custom_message

    def initialize(data)
      super
      @custom_message = data
    end
  end

  included do
    respond_to :json

    rescue_from ExceptionHandler::ApiError, with: :api_error
  end

  API_ERROR_CODES = {
    "400001": "missing_required_param"
  }.freeze

  STATUS_HTML_CODES = {
    "400001": :bad_request
  }.freeze

  private

  def api_error(error)
    message = error.custom_message

    key = API_ERROR_CODES[message[:code].to_sym]
    error_title = I18n.t("api.error.#{key}")
    error_message = I18n.t("api.message.#{key}_msg")
    error_html = STATUS_HTML_CODES[message[:code].to_sym] || :bad_request

    error_data = {
      "error_code": message[:code],
      "error_title": error_title,
      "error_message": error_message
    }

    render_error(error_data, error_html)
  end
end
