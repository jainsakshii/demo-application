class CheckoutController < ApplicationController
  def create
    # @seat = Seat.find(params[:id])
    @showtime = Showtime.find(params[:id])
    email = current_user.email
    total_tickets = @showtime.seats.count
    # byebug
    @session = Stripe::Checkout::Session.create({
      # customer_email = email,
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        price_data: {currency: 'inr',product_data: {name: @seat.name}, unit_amount: @seat.price},
        quantity: 1,
      } ],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
      })  
      respond_to do |format|
        format.js
      end
    end
  #   @session = Stripe::Checkout::Session.create({
  #     byebug
  #     success_url: root_url,
  #     line_items: [
  #       {price: @seat.price, quantity: params[:no_of_tickets]},
  #     ],
  #     mode: 'payment',
  #     })
      
      
  # end

  

  # @course = Course.find(params[:id])
  # @session = Stripe::Checkout::Session.create({
  #     payment_method_types: ['card'],
  #     customer_email: current_user.email,
  #     line_items: [{
  #         price_data: {currency: 'inr', product_data: {name: @course.course_name}, unit_amount: @course.course_price},
  #         quantity: 1,
  #     } ],
  #     mode: 'payment',
  #     success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}" + "&payment_id=" + @payment.id.to_s,
  #     cancel_url: checkout_cancel_url + "?session_id={CHECKOUT_SESSION_ID}" + "&payment_id=" + @payment.id.to_s
  #   })
  #   respond_to do |format|
  #     format.js
    # private
    # def make_bookings
    #   if (@booked_seats.length()>0)
    #     @booking = current_user.bookings.create(state: "processed", showtime_id: @showtime.id, total_seats_booked: params[:no_of_tickets].to_i)
    #     BookingMailMailer.create_mail_to_user(@booking).deliver_now
    #   end
    # end
  end


# {price: 'price_1MvgTCSD6cQ7Pxum0CBUdhvm', quantity: params[:no_of_tickets].to_i},