# frozen_string_literal: true

class MoviesController < ApplicationController
  #load_and_authorize_resource
  after_action :make_bookings,  only: %i[book_tickets]
  def index
    # debugger
    @q = Movie.ransack(params[:q])
    @movies = @q.result.kept
    # @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end
  
  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path
    else  
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    
    if @movie.update(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.discard

    redirect_to movies_path, status: :see_other
  end

  def show_seats
    curr_movie = Movie.find(params[:id])
    @theatres = {}
    Theatre.all.each do |theatre|
      @showtimes = []
      theatre.screen.showtimes.each do |temp|
        #debugger
        if (temp.movie.id==curr_movie.id)
          #puts "hereeee"
          @showtimes << temp
        end
      end
      @theatres[theatre]=@showtimes
    end
  end

  def book_tickets
    @showtime = Showtime.find(params[:show_id])
    @seats = @showtime.seats
    @booked_seats = []
    seats_to_book = params[:no_of_tickets].to_i
    if seats_to_book > @seats.where(availablity_status: 'true').count
      redirect_to theatre_screen_showtime_path(theatre_id:params[:theatre_id],screen_id:params[:screen_id]), alert: "Seats not available"
    else
      @seats.each do |seat|
        if seat.availablity_status == true && seats_to_book > 0
          seat.availablity_status = false
          seat.save
          @booked_seats << seat
          seats_to_book = seats_to_book - 1
        end
      end
      redirect_to theatre_screen_showtime_path(theatre_id:params[:theatre_id],screen_id:params[:screen_id])
    end
    # debugger
  end

  private
  
  def make_bookings
    @booked_seats.each do |seat|
      @booking = current_user.bookings.create(state: "processed", showtime_id: @showtime.id, seat_id: seat.id)
    end
    if (@booked_seats.length()>0)
      BookingMailMailer.create_mail_to_user(@booking).deliver_now
    end
  end
    
  def movie_params
    params.require(:movie).permit(:name,:genre,:description, :movie_poster)
  end

end
