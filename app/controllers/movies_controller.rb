class MoviesController < ApplicationController
  load_and_authorize_resource
  def index
    #debugger
    @q = Movie.ransack(params[:q])
    @movies = @q.result 
    #@movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end
  
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

  def edit 
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    
    if @movie.update(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end 

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    redirect_to movies_path, status: :see_other
  end

  private
  
  def movie_params
    params.require(:movie).permit(:name,:genre,:description)
  end

end
