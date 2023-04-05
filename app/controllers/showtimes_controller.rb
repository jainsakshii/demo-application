class ShowtimesController < ApplicationController
  def show
    @showtime = Showtime.find(params[:id])
    @seats = @showtime.seats
  end

 # private
  #def showtime_params
   # params.require(:showtime).permit(:name,:schedule, :movie_id)
  #end
end