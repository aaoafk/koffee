class ApplicationController < ActionController::Base
  include CookieAuthenticatable

  before_action :can_edit, only: [:edit, :update, :destroy]

  private

  def can_edit
    if @reservation&.user_id == Current.user_id
      return
    else
      redirect_to reservations_path, notice: "You can't edit this reservation since you didn't create it.", status: :unauthorized
    end
  end
end
