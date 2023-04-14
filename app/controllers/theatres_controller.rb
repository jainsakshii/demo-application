# frozen_string_literal: true

class TheatresController < ApplicationController
  before_action :authenticate_user!
  before_action :get_theatre, only: [:show,:edit,:update,:destroy]
  load_and_authorize_resource

  def index
    #@theatres = Theatre.all
    @theatres = Theatre.accessible_by(current_ability)
  end

  def new
    @theatre = Theatre.new
  end

  def show
  end
   
  def create
    @theatre = Theatre.create(theatre_params)
    if @theatre.save
      user = User.find(theatre_params[:user_id])
      user.add_role :theatre_admin
      redirect_to theatres_path
    else
      render :new
    end
  end

  def edit
  end
   
  def update
    if @theatre.update(theatre_params)
      user = User.find(theatre_params[:user_id])
      user.add_role :theatre_admin
      redirect_to theatres_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @theatre.destroy
    redirect_to theatres_path, status: :see_other
  end

  private

  def get_theatre
    @theatre = Theatre.find(params[:id])
  end
  
  def theatre_params
    params.require(:theatre).permit(:name, :venue, :contact_number, :user_id)
  end
end
