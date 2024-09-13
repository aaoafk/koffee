class ApplicationController < ActionController::Base
  include CookieAuthenticatable

  before_action :can_edit, only: [:edit, :update, :destroy]

  private
  
  # def can_edit?
  #   curr_cookie = decode_cookie
  #   curr_cookie['ip_address'] == Current.remote_ip && curr_cookie['user_agent'] == Current.user_agent
  # end

  def can_edit
    if @reservation&.user_id == Current.user_id
      return
    else
      redirect_to reservations_path, notice: "You can't edit this reservation since you didn't create it.", status: :unauthorized
    end
  end
end
