# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource
  before_action :get_movie, only: [:show,:edit,:update,:destroy]
  # after_action :make_bookings,  only: %i[book_tickets]
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result.kept
  end

  def show; end
  
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

  def edit; end
  
  def update    
    if @movie.update(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end
  
  def destroy
    @movie.discard
    redirect_to movies_path, notice: "Movie removed"
  end
  
  def show_seats
    curr_movie = Movie.find(params[:id])
    @theatres = {}
    Theatre.all.each do |theatre|
      @showtimes = []
      theatre.screen.showtimes.each do |temp|
        if (temp.movie.id==curr_movie.id)
          @showtimes << temp
        end
      end
      @theatres[theatre]=@showtimes
    end
  end
  
  # def book_tickets
  #   @showtime = Showtime.find(params[:show_id])
  #   @seats = @showtime.seats
  #   @booked_seats = []
  #   @seats_to_book = params[:no_of_tickets].to_i
  #   if @seats_to_book > @seats.where(availablity_status: 'true').count
  #     redirect_to theatre_screen_showtime_path(theatre_id:params[:theatre_id],screen_id:params[:screen_id]), alert: "Seats not available"
  #   else
  #     @seats.each do |seat|
  #       if seat.availablity_status == true && @seats_to_book > 0
  #         seat.availablity_status = false
  #         seat.save
  #         @booked_seats << seat
  #         @seats_to_book = @seats_to_book - 1
  #       end
  #     end
  #     # redirect_to theatre_screen_showtime_path(theatre_id:params[:theatre_id],screen_id:params[:screen_id])
  #   end
  # end
  
                                            
  private
  
  # def make_bookings
  #   if (@booked_seats.length()>0)
  #     @booking = current_user.bookings.create(state: "processed", showtime_id: @showtime.id, total_seats_booked: params[:no_of_tickets].to_i)
  #     # BookingMailMailer.create_mail_to_user(@booking).deliver_now
  #   end
  # end
  
  def movie_params
    params.require(:movie).permit(:name,:genre,:description, :movie_poster)
  end
  
  def get_movie
    @movie = Movie.find(params[:id])
  end
  
end
