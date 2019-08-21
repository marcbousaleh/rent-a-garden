class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @garden = Garden.find(params[:garden_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.garden = Garden.find(params[:garden_id])
    @booking.renter = current_user
    time = (@booking.end_date - @booking.start_date) / 3600
    @booking.price = @booking.garden.price * time
    @booking.status = 'available'

    if @booking.save
      redirect_to payment_confirmation_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :garden_id)
  end
end
