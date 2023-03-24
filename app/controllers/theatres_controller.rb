class TheatresController < ApplicationController
  def index
    @theatres = Theatre.all
  end

  def new
    @theatre = Theatre.new
  end

  def show
    @theatre = Theatre.find(params[:id])
    # @screen = @theatre.screen
  end
   
  def create
    @theatre = Theatre.create(theatre_params)
    if @theatre.save
      user_id = theatre_params[:theatre_administrator_id]
      user = User.find(user_id)
      user.add_role :theatre_admin
      redirect_to theatres_path
    else
      render :new
    end
  end

  def edit
    @theatre = Theatre.find(params[:id])
  end
   
  def update 
    @theatre = Theatre.find(params[:id])

    if @theatre.update(theatre_params)
      user_id = theatre_params[:theatre_administrator_id]
      user = User.find(user_id)
      user.add_role :theatre_admin
      redirect_to theatres_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @theatre = Theatre.find(params[:id])
    @theatre.destroy
    redirect_to theatres_path, status: :see_other
  end
  private
  def theatre_params
    params.require(:theatre).permit(:name,:venue,:contact_number,:theatre_administrator_id)
  end

end
