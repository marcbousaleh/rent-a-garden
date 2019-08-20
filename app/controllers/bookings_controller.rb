class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to payment_confirmation_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:price, :status, :start_date, :end_date)
  end
end
