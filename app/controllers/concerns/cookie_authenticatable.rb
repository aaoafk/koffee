module CookieAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :set_user_id_from_cookie
  end

  private

  def set_user_id_from_cookie
    @user_id = decode_cookie || generate_user_id
    set_cookie(@user_id)
  end

  def decode_cookie
    JWT.decode(cookies.signed[:user_id], Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })[0]['user_id']
  rescue JWT::DecodeError
    nil
  end

  def generate_user_id
    SecureRandom.uuid
  end

  def set_cookie(user_id)
    token = JWT.encode({ user_id: user_id }, Rails.application.secrets.secret_key_base, 'HS256')
    cookies.signed[:user_id] = { value: token, expires: 1.year.from_now, httponly: true }
  end
end
