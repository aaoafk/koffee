class ApplicationController < ActionController::Base
  include CookieAuthenticatable

  before_action :verify_ownership, only: [:edit, :update, :destroy]

  private
  
  def verify_ownership
    unless @reservation&.user_id == @user_id
      redirect_to reservations_path, alert: "You don't have permission to modify this reservation."
    else
      redirect_to reservations_path, notice: "You can't edit this reservation since you didn't create it.", status: :see_other
    end
  end
end
