class ShowtimesController < ApplicationController
  before_action :authenticate_user!
  def show
    @showtime = Showtime.find(params[:id])
    @movie = @showtime.movie
    @seats = @showtime.seats
  end 

  # def create
  #   @start = Showtime.find(params[:])
  #   @end = Showtime.find(params[:end_date])
  # end
end