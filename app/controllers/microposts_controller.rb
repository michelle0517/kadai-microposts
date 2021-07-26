class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropostを投稿しました。'
      redirect_to root_url
    else
      @pagy, @microposts = pagy(current_user.feed_microposts.order(id: :desc))
      flash.now[:danger] = 'Micropostの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropostを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def show
  @favorite = current_user.favorites.find_by(micropost_id: @micropost.id)
  @favorites = @micropost.favorite_users
  favorites = Favorite.where(user_id: current_user.id).pluck(:micropost_id)
  @likes = Micropost.find(favorites)
  end
  
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
  
end
