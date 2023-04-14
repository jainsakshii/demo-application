class BookingMailMailer < ApplicationMailer
  def create_mail_to_user(booking)
   @booking = booking
   @user = User.find_by(id:@booking.user_id)
   @user_email = @user.email
   #@seat_id = booking.seat_id
   @showtime_id = booking.showtime_id
   @show = Showtime.find_by(id:@showtime_id)
   @movie_name = @show.movie.name
   @theatre_name = @show.screen.theatre.name
   #byebug
   mail to: @user_email, subject: "You got booking at movie planet :)"
  end
end
