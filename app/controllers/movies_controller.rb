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
                                            
  private
 
  def movie_params
    params.require(:movie).permit(:name,:genre,:description, :movie_poster)
  end
  
  def get_movie
    @movie = Movie.find(params[:id])
  end
  
end
