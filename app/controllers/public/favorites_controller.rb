class Public::FavoritesController < ApplicationController

  def create
    @spot = Spot.find(params[:spot_id])
    favorite = @spot.favorites.new(user_id: current_user.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    favorite = @spot.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    # redirect_to request.referer
  end


end
