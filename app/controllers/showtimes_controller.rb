class ShowtimesController < ApplicationController
  before_action :authenticate_user!
  def show
    @showtime = Showtime.find(params[:id])
    @movie = @showtime.movie
    @seats = @showtime.seats
  end 
end
