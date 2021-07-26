class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
#binding.pry
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = 'Micropostをお気に入りしました。'
    redirect_to root_url
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = 'Micropostのお気に入りを解除しました。'
    #このページのままに飛んで欲しい
    redirect_back(fallback_location: root_path)
  end
end
