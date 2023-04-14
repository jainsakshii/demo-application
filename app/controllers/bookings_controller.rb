class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_details, only: %i[payment_initiate create ]
  
  def create
    # debugger
    @seats = @showtime.seats
    @booked_seats = []
    @seats_to_book = params[:no_of_tickets].to_i
    if @seats_to_book > @seats.where(availablity_status: 'true').count
      redirect_to theatre_screen_showtime_path(theatre_id:params[:theatre_id],screen_id:params[:screen_id]), alert: "Seats not available"
    else
      @seats.each do |seat|
        if seat.availablity_status == true && @seats_to_book > 0
          seat.availablity_status = false
          seat.save
          @booked_seats << seat
          @seats_to_book = @seats_to_book - 1
        end
      end
      if (@booked_seats.length()>0)
        @booking = current_user.bookings.create(state: "processed", showtime_id: @showtime.id, total_seats_booked: params[:no_of_tickets].to_i)
        # BookingMailMailer.create_mail_to_user(@booking).deliver_now
      end
      redirect_to cart_movie_booking_path(id:@booking, show_id: @showtime,theatre_id:params[:theatre_id],screen_id:params[:screen_id],seats: params[:no_of_tickets])
    end
  end

  def cart
    @seats = params[:seats]
    @booking = Booking.find(params[:id])
  end

  def payment_initiate
    email = current_user.email
    total_tickets = @showtime.seats.count
    # byebug
    @session = Stripe::Checkout::Session.create({
      # customer_email = email,
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        price_data: {currency: 'inr',product_data: {name: @showtime.name }, unit_amount: 100*100},
        quantity: @quantity,
      } ],
      mode: 'payment',
      success_url: show_bookings_url,
      cancel_url: payment_cancel_movie_booking_url(movie_id: @movie,id:params[:id],seats: @quantity,show_id: params[:show_id]),
      })  
    respond_to do |format|
      format.js
    end
  end

  def payment_cancel
    @showtime = Showtime.find(params[:show_id])
    @movie = @showtime.id
    @booking = Booking.find(params[:id])
    @booking.destroy
    @quantity = params[:seats].to_i
    @seats = @showtime.seats  
    @seats.each do |seat|
      if seat.availablity_status == false && @quantity > 0
        seat.availablity_status = true
        seat.save
        @quantity = @quantity - 1
      end
    end
  end

  private

  def get_details
    @showtime = Showtime.find(params[:show_id])
    @movie = @showtime.id
    @quantity = params[:seats].to_i
  end
end
