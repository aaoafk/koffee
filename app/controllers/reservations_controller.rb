class ReservationsController < ApplicationController
  # TODO: ActionDispatch::Cookies::CookieOverflow in ReservationsController#new sometimes
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.all.order(:day)
  end

  def show
  end

  def new
    @names = Name.all
    @reservation = Reservation.new
  end

  def create
    @names = Name.all
    name = Name.find_by value: params[:reservation][:name]
    @reservation = Reservation.new(reservation_params.merge(name: name))
    if @reservation.save
      redirect_to reservations_path, notice: 'Your Koffee reservation was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_path(@reservation), notice: 'Your Koffee reservation was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to root_path, notice: 'Your Koffee reservation was successfully deleted.', status: :see_other
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end


  def reservation_params
    params.require(:reservation).permit(:day, :name).merge(user_id: @user_id)
  end
end
