# frozen_string_literal: true

class ScreensController < ApplicationController
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
    params.require(:screen).permit(:name,showtimes_attributes: [:id,:name,:schedule,:movie_id,:_destroy])
  end
end