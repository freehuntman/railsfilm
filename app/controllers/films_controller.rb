class FilmsController < ApplicationController
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    @film.save
      redirect_to films_path, notice: "You have created an awesome film!"
  end

  def update
    @film = Film.find(params[:id])
    @film.update(film_params)
    flash[:notice] = "Update Success!"
    redirect_to films_path
  end

  def destroy
    @film = Film.find(params[:id])
    @film.destroy
    flash[:alert] = "What a shame!"
    redirect_to films_path
  end




  private

  def film_params
    params.require(:film).permit(:title, :description)
  end
end
