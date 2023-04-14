# frozen_string_literal: true

class ScreensController < ApplicationController
  before_action :authenticate_user!
  def index
    @screens = Screen.all
  end
  def show
    @theatre = Theatre.find(params[:theatre_id])
    @screen = @theatre.screen
  end
  # def new
  #   @screen = Screen.new 
  # end
  # def create
  #   @screen = Screen.new(screen_params)
  #   if @screen.save
  #     redirect_to @screen
  #   else  
  #     redirect_to @screen 
  #   end
  # end
  def edit
    @screen = Screen.find(params[:id])
  end
  def update 
    @screen = Screen.find(params[:id])
    if @screen.update(screen_params)
      @screen.showtimes.each do |showtime|
        if (showtime.start_date and showtime.end_date)
          (showtime.start_date..showtime.end_date).each do |date|
            @screen.showtimes.create(name: showtime.name, schedule: showtime.schedule, scheduleDate: date,movie_id: showtime.movie_id)
          end
        end
      end
      redirect_to theatre_screen_path(theatre_id: @screen.theatre_id, id: @screen.id)
    else
      render :edit, status: :unprocessable_entity 
    end
  end
  
  def destroy
    @screen = Screen.find(params[:id])
    @screen.destroy
    redirect_to root_path, status: :see_other
  end

  private
  def screen_params
    params.require(:screen).permit(:name,showtimes_attributes: [:id,:name,:schedule,:scheduleDate,:movie_id, :start_date, :end_date, :_destroy])
  end
end

# def update
#   @screen = Screen.find(params[:id])
#   if (@screen.update(screen_params))
#     @screen.showtimes.each do |showtime|
#       if (showtime.scheduleDate < Date.today)
#         showtime.destroy
#         #render :edit, status: :unprocessable_entity
#         redirect_to theatre_screen_path(theatre_id: @screen.theatre_id, id: @screen.id), alert: "Date cannot be in the past."
#       end
#       if (showtime.start_date and showtime.end_date)
#         (showtime.start_date..showtime.end_date).each do |date|
#           @screen.showtimes.create(name: showtime.name, schedule: showtime.schedule, scheduleDate: date,movie_id: showtime.movie_id)
#         end
#       end
#     end
#   else
#     render :edit, status: :unprocessable_entity
#   end
# end