module CookieAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def set_current_user
    set_or_generate_user_id_from_cookie
    Current.user_id ||= decode_cookie['user_id']
    Current.ip_address ||= request.remote_ip
    Current.user_agent ||= request.user_agent
  end

  def set_or_generate_user_id_from_cookie
    @user_id = decode_cookie || generate_user_id
    set_cookie(@user_id)
  end

  def generate_user_id
    SecureRandom.uuid
  end

  def decode_cookie
    JWT.decode(cookies.signed[:user_id], Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })[0] # Array @ 0 idx is the payload
  rescue JWT::DecodeError
    nil
  end

  def set_cookie(user_id)
    token = JWT.encode({ user_id: user_id, ip_address: request.remote_ip, user_agent: request.user_agent }, Rails.application.secrets.secret_key_base, 'HS256')
    cookies.signed[:user_id] = { value: token, expires: 1.year.from_now, httponly: true }
  end

end
