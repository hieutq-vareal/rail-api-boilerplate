# frozen_string_literal: true

class RefreshToken < ApplicationRecord
  belongs_to :user

  scope :not_expired, -> { where("exp > ?", Time.current) }

  before_create :set_crypted_token_and_expire_time

  class << self
    def renew_token!(old_token)
      if (refresh_token = not_expired.find_by crypted_token: old_token)
        refresh_token.update!(
          crypted_token: Digest::SHA256.hexdigest(SecureRandom.hex),
          old_token:,
          exp: 24.hours.from_now
        )
      else
        refresh_token = find_by! old_token:
      end
      refresh_token
    rescue ActiveRecord::RecordNotFound
      raise ExceptionHandler::ApiError, { code: "401002" }
    end
  end

  private

  def set_crypted_token_and_expire_time
    self.crypted_token = Digest::SHA256.hexdigest(SecureRandom.hex)
    self.exp = 24.hours.from_now
  end
end
