class FilmsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_film_and_check_permission, only: [:edit, :update, :destory]

  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
    @reviews = @film.reviews.recent.paginate(:page => params[:page], :per_page =>3 )
  end

  def edit

  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    @film.user = current_user

    if @film.save
      redirect_to films_path, notice: "You have created an awesome film!"
    else
      render :new
    end
  end

  def update


        if @film.update(film_params)
          redirect_to films_path, notice: "Update Success"
        else
          render :edit
        end
      end

  def destroy

    @film.destroy
    flash[:alert] = "What a shame!"
    redirect_to films_path
  end




   def join
    @film = Film.find(params[:id])

     if !current_user.is_member_of?(@film)
       current_user.join!(@film)
       flash[:notice] = "加入本讨论版成功！"
     else
       flash[:warning] = "你已经是本讨论版成员了！"
     end

     redirect_to film_path(@film)
   end

   def quit
     @film = Film.find(params[:id])

     if current_user.is_member_of?(@film)
       current_user.quit!(@film)
       flash[:alert] = "已退出本讨论版！"
     else
       flash[:warning] = "你不是本讨论版成员，怎么退出 XD"
     end

     redirect_to film_path(@film)
   end





  private

  def film_params
    params.require(:film).permit(:title, :description)
  end

  def find_film_and_check_permission
    @film = Film.find(params[:id])

    if current_user != @film.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

end
