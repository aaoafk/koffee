class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @names = Name.all
    @reservations = Reservation.all.order(:day)
    @reservations_exist = Reservation.count > 0
  end

  def show
  end

  def new
    @names = Name.all
    @reservation = Reservation.new
  end

  def create
    @names = Name.all
    name = Name.find_by(value: params[:reservation][:name])
    @reservation = Reservation.new(reservation_params.merge(name: name))
    if @reservation.save
      redirect_to reservations_path, notice: 'Your Koffee reservation was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy!
    redirect_to root_path, notice: 'Your Koffee reservation was successfully deleted.', status: :see_other
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:day, :name).merge(user_id: Current.user_id)
  end
end
