class ShowtimesController < ApplicationController
  def show
    @showtime = Showtime.find(params[:id])
    @seats = @showtime.seats
  end
end