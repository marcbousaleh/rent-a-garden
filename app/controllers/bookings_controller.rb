class BookingsController < ApplicationController
  def index
    flash[:alert] = nil
    bookings = policy_scope(Booking)
    @bookings = remove_owner(bookings)
  end

  def new
    @garden = Garden.find(params[:garden_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @garden = Garden.find(params[:garden_id])
    @booking.garden = @garden
    authorize @booking
    add_booking_attributes(@booking)

    if check_if_reserved?(@garden, @booking)
      flash[:alert] = "This garden is already booked on this date"
      render :new
    else
      @booking.save
      redirect_to bookings_path
    end
  end

  private

  def check_if_reserved?(garden, booking)
    garden.bookings.each do |reservation|
      if ((booking.start_date > reservation.start_date) && (booking.start_date < reservation.end_date)) || ((booking.end_date > reservation.start_date) && (booking.end_date < reservation.end_date)) || ((booking.start_date < reservation.start_date) && (booking.end_date > reservation.end_date))
        return true
      end
    end
    return false
  end

  def add_booking_attributes(booking)
    booking.renter = current_user
    time = (booking.end_date - booking.start_date) / 3600
    booking.price = booking.garden.price * time
    booking.status = 'available'
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :garden_id)
  end

  def remove_owner(bookings)
    bookings.reject do |booking|
      booking.garden.owner == current_user
    end
  end
end
