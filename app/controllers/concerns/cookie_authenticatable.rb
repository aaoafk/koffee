# @user_info : hash
module CookieAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def set_current_user
    user_info = extract_or_initialize_cookie
    Current.user_id ||= user_info['user_id']
    Current.ip_address ||= user_info['ip_address']
    Current.user_agent ||= user_info['user_agent']
  end

  def extract_or_initialize_cookie
    initialize_cookie && extract_cookie
  end

  def extract_cookie
    JSON.parse(cookies.signed[:user_info])
  end

  def initialize_cookie
    if cookies.signed[:user_info].nil?
      token = { "user_id" => SecureRandom.uuid, "ip_address" => request.remote_ip, "user_agent" => request.user_agent }
      cookies.signed[:user_info] = { value: JSON.generate(token), expires: 1.year.from_now, httponly: true }
    end
    true
  end
end
