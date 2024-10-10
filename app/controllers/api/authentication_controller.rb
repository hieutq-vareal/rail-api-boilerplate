# frozen_string_literal: true

module Api
  class AuthenticationController < BaseController
    before_action :authenticated_user!

    private

    def authenticated_user!
      # do something
    end
  end
end
